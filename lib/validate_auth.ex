defmodule ValidateAuth do
  @moduledoc """
  Documentation for ValidateAuth.
  """
  import Plug.Conn

  def test(), do: IO.inspect("aqui")

  def init(options), do: options

  def call(conn, _opts) do
    # get token from headers
    req_headers = Enum.into(conn.req_headers, %{})
    IO.inspect(conn)

    if is_nil(req_headers["authorization"]) do
      conn
      |> send_resp(:unauthorized, "Authorization token is required.")
    end

    token = String.replace(req_headers["authorization"], "Bearer ", "")

    case token_legacy_validation(token) do
      {:ok, %HTTPoison.Response{status_code: 401, headers: _headers, body: _body}} ->
        conn
        |> send_resp(:unauthorized, "Authorization token is required.")

      {:ok, %HTTPoison.Response{status_code: 200, headers: _headers, body: _body}} ->
        conn
    end
  end

  def token_legacy_validation(token) do
    HTTPoison.start()
    HTTPoison.post(System.get_env("AUTH_ENDPOINT"), [], [{"Authorization", "bearer " <> token}])
  end
end
