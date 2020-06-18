defmodule ValidateAuth.Auth.AuthErrorHandler do
  @moduledoc """
    Auth Handler Error module
  """
  import Plug.Conn

  def auth_error(conn, {type, _}, _opts), do: auth_error_handler(conn, to_string(type))
  def auth_error(conn), do: auth_error_handler(conn, "unauthenticated")

  defp create_body(type), do: Poison.encode!(%{msg: to_string(type), code: 1039})

  defp auth_error_handler(conn, type) do
    body = create_body(type)

    IO.inspect(Guardian.Plug.current_token(conn), label: "TOKENNNNNNNNNNN")
    IO.inspect(body, label: "ERORRRRRRRRRRRRRRRRRRRRR")
    IO.inspect(type, label: "ERORR")

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(401, body)
    |> halt
  end
end
