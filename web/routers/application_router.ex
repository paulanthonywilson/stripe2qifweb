defmodule EnsureSSL do
  def service(conn, fun) do
    conn = conn.fetch([:cookies, :params, :headers])
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


  # It is common to break your Dynamo into many
  # routers, forwarding the requests between them:
  # forward "/posts", to: PostsRouter

  get "/" do
    conn = conn.assign(:title, "Welcome to Dynamo!")
    render conn, "index.html"
  end
end
