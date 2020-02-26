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

    if is_nil(req_headers["authorization"]) do
      conn
      |> send_resp(:unauthorized, "Authorization token is required.")
    end

    token = String.replace(req_headers["authorization"], "Bearer ", "")
    token_legacy_validation(token)
    conn
  end

  def token_legacy_validation(token) do
    HTTPoison.start()

    resp =
      HTTPoison.post(System.get_env("AUTH_ENDPOINT"), [], [{"Authorization", "bearer " <> token}])

    IO.inspect(resp)
  end
end
