defmodule ValidateAuth.Auth.AuthPipeline do
  @moduledoc """
    Auth pipeline module
  """
  use Guardian.Plug.Pipeline,
    otp_app: :validate_auth,
    module: ValidateAuth.Guardian,
    error_handler: ValidateAuth.Auth.AuthErrorHandler

  # Guardian
  plug(Guardian.Plug.VerifyHeader, realm: "Bearer")
  plug(Guardian.Plug.VerifySession, claims: %{"typ" => "access"})
  plug(Guardian.Plug.EnsureAuthenticated)
end
