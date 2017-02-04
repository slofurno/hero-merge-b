defmodule Heromerge.HeroRouter do
  use Plug.Router
  alias Heromerge.MergeRequest
  alias Heromerge.Hero
  alias Heromerge.Hero.Attributes
  alias Heromerge.Heroes

  @as_hero %Hero{attributes: %Attributes{}}

  plug :match
  plug :dispatch

  get "/" do
    heroes = Poison.encode!(Heroes.get)

    conn
    |> put_resp_content_type("application/json; charset=utf-8")
    |> send_resp(200, heroes)
  end

  post "/" do
    with {:ok, body, conn} <- read_body(conn),
      {:ok, hero} <- Poison.decode(body, as: @as_hero),
      {:ok, hero} <- Hero.check_hero(hero),
      {:ok, hero} <- Heroes.create(hero)
    do
      conn
      |> put_resp_content_type("application/json; charset=utf-8")
      |> send_resp(200, hero |> Poison.encode!)
    end
    |> case do
      {:error, error} -> send_resp(conn, 400, error)
      conn -> conn
    end
  end

  post "/merge" do

    with {:ok, body, conn} <- read_body(conn),
      {:ok, merge_request} <- Poison.decode(body, as: %MergeRequest{hero: @as_hero}),
      {:ok, hero} <- MergeRequest.check_hero(merge_request),
      {:ok, hero} <- Hero.check_hero(hero),
      {:ok, hero} <- Heroes.create(hero),
      {:ok, hero} <- Poison.encode(hero)
    do
      conn
      |> put_resp_content_type("application/json; charset=utf-8")
      |> send_resp(200, hero)
    end
    |> case do
      {:error, error} -> send_resp(conn, 400, error)
      conn -> conn
    end
  end

end

