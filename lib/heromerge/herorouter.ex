defmodule Heromerge.HeroRouter do
  use Plug.Router
  alias Heromerge.MergeRequest
  alias Heromerge.Hero
  alias Heromerge.Hero.Attributes

  @as_hero %Hero{attributes: %Attributes{}}

  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200, "all heroes")
  end

  post "/" do
    {:ok, body, conn} = read_body(conn)
    hero = Poison.decode!(body, as: @as_hero)
  end

  post "/merge" do
    {:ok, body, conn} = read_body(conn)
    hero = Poison.decode!(body, as: %MergeRequest{hero: @as_hero})
  end

end

