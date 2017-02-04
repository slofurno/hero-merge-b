defmodule Heromerge.Router do
  use Plug.Router
  alias Heromerge.HeroRouter

  plug :match
  plug :dispatch

  get "/hello" do
    send_resp(conn, 200, "world")
  end

  forward "/api/heroes", to: HeroRouter

  match _ do
    IO.inspect conn
    send_resp(conn, 404, "oops")
  end
end
