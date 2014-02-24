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
    conn
  end
end
