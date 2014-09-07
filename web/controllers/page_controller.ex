defmodule Stripe2qifweb.PageController do
  use Phoenix.Controller

  def index(conn, params) do
    render_index conn, params, nil
  end

  def qif(conn, params) do
    key = params["stripe_key"]
    tito = params["tito"] == "true"
    date = parse_date(params["date"])

    download_qif conn, params, {key, tito, date}
  end

  def not_found(conn, _params) do
    render conn, "not_found"
  end

  def error(conn, _params) do
    render conn, "error"
  end

  defp download_qif conn, params,  {_, _, :error} do
    render_index conn, params,
      "I'm afraid \"#{params["date"]}\" is not a date I can work with. Sorry."
  end

  defp download_qif conn, params,  {"", _, _} do
    render_index conn, params,
      "I think you forgot to enter a Stripe key."
  end


  defp download_qif conn, params, {key, tito, date} do
    try do
      Stripe2qif.run(key, tito, date)  |> download(conn)
    rescue
      e in RuntimeError -> render_index conn, params, e.message 
    end
  end



  defp download content, conn do
    conn
      |> put_resp_header("Content-Disposition", "attachment; filename=stripe.qif")
      |> send_response(200, "application/x-qw", content)
  end
  defp render_index(conn, params, error) do
    render conn, "index",
      date: params["date"],
      stripe_key: params["stripe_key"],
      tito_check: tito_check_attribute(params),
      error: error
  end


  defp parse_date("") do
    nil
  end

  defp parse_date date do
    Stripe2qif.DateConvert.parse_date(date)
  end


  defp tito_check_attribute(params) do
    case params["tito"] do
      "true" -> "checked"
      _ -> ""
    end
  end
end
