defmodule EnsureSSL do
  def service(conn, fun) do
    conn = conn.fetch([:cookies, :params, :headers])
    conn = conn.assign(:layout, "main")
    if conn.req_headers["x-forwarded-proto"] == "http" do
      ApplicationRouter.no_ssl(conn, conn.req_headers["host"])
    else
      fun.(conn)
    end
  end
end

defmodule ApplicationRouter do
  use Dynamo.Router
  filter EnsureSSL

  def no_ssl(conn, host) do
    redirect conn, to: "https://#{host}"
  end


  get "/" do
    conn = conn.assign(:title, "Stripe QIF downloader")
    render conn, "index.html"
  end

  get "/qif" do
    key = conn.params[:stripe_key]
    tito = conn.params[:tito] == "true"
    date = Stripe2qif.DateConvert.parse_date(conn.params[:date])
    download_qif conn, {key, tito, date}
  end

  def download_qif conn, {_, tito, :error} do
    conn = conn.assign(:error, "I'm afraid \"#{conn.params[:date]}\" is not a date I can work with. Sorry.")
    render conn, "error.html"
  end

  def download_qif conn, {key, tito, date} do
    Stripe2qif.run(key, tito, date) |> download(conn)
  end


  defp download(content, conn) do
    conn = conn.put_resp_header("Content-Disposition", "attachment; filename=stripe.qif")
    .put_resp_header("Content-Type", "application/x-qw")

    conn.resp_body content

  end
end
