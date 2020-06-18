defmodule ValidateAuth do
  @moduledoc """
  Documentation for ValidateAuth.
  """
  import Plug.Conn

  # alias ValidateAuth.Auth.AuthPipeline
  # plug(AuthPipeline)

  # @connetion %Plug.Conn{
  #   adapter: {Plug.Cowboy.Conn, ""},
  #   assigns: %{},
  #   before_send: "[#Function<0.103398411/1 in Plug.Telemetry.call/2>]",
  #   body_params: %{},
  #   cookies: %Plug.Conn.Unfetched{aspect: :cookies},
  #   halted: false,
  #   host: "localhost",
  #   method: "GET",
  #   owner: "#PID<0.923.0>",
  #   params: %{
  #     "company_id" => "1",
  #     "end_date" => "2019-11-14 00:00:00",
  #     "start_date" => "2019-07-30 00:00:00"
  #   },
  #   path_info: ["api", "v1", "get", "section1"],
  #   path_params: %{},
  #   port: 4006,
  #   private: %{
  #     StatisticsWeb.Router => {[], %{}},
  #     :phoenix_action => :get_section1,
  #     :phoenix_controller => StatisticsWeb.V1.StatisticsController,
  #     :phoenix_endpoint => StatisticsWeb.Endpoint,
  #     :phoenix_format => "json",
  #     :phoenix_layout => {StatisticsWeb.LayoutView, :app},
  #     :phoenix_router => StatisticsWeb.Router,
  #     :phoenix_view => StatisticsWeb.V1.StatisticsView,
  #     :plug_session_fetch => "#Function<1.112964096/1 in Plug.Session.fetch_session/1>"
  #   },
  #   query_params: %{
  #     "company_id" => "1",
  #     "end_date" => "2019-11-14 00:00:00",
  #     "start_date" => "2019-07-30 00:00:00"
  #   },
  #   query_string:
  #     "start_date=2019-07-30%2000%3A00%3A00&end_date=2019-11-14%2000%3A00%3A00&company_id=1",
  #   remote_ip: {0, 0, 0, 0, 0, 0, 0, 1},
  #   req_cookies: %Plug.Conn.Unfetched{aspect: :cookies},
  #   req_headers: [
  #     {"accept", "*/*"},
  #     {"authorization",
  #      "Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJhdXRoZW50aWNhdGlvbiIsImV4cCI6MTYwMjg2OTQ2NSwiaWF0IjoxNTkyNTAxNDY1LCJpc3MiOiJhdXRoZW50aWNhdGlvbiIsImp0aSI6IjA1ODU0NzI3LWFkNGYtNDlmMi1hODMwLWQ4YmY4N2QxZWFhZCIsIm5iZiI6MTU5MjUwMTQ2NCwic3ViIjoiMyIsInR5cCI6ImFjY2VzcyJ9.ZYDxJpQJNTxwIApofk4uY7DDVNtkXpO1A8x4pRD5UoAe-lOVwPVrgD0xJWBCfgra4Kr9kM8UZcjA0Etm76Jh_g"},
  #     {"host", "localhost:4006"},
  #     {"user-agent", "insomnia/2020.2.2"}
  #   ],
  #   request_path: "/api/v1/get/section1",
  #   resp_body: nil,
  #   resp_cookies: %{},
  #   resp_headers: [
  #     {"cache-control", "max-age=0, private, must-revalidate"},
  #     {"x-request-id", "Fhm7HAB_SGiYBboAAGrB"},
  #     {"access-control-allow-origin", "*"},
  #     {"access-control-expose-headers", ""},
  #     {"access-control-allow-credentials", "true"}
  #   ],
  #   scheme: :http,
  #   script_name: [],
  #   secret_key_base: ":...,",
  #   state: :unset,
  #   status: nil
  # }

  def init(options), do: options

  def call(@connetion, _opts) do
    {:ok, "ok"}
  end

  def token_legacy_validation(token) do
    auth =
      System.get_env("AUTH_ENDPOINT") ||
        "http://internal-ALB-prod-admin-internal-2147412802.us-east-1.elb.amazonaws.com:85/api/v1/session/verify_token"

    HTTPoison.start()
    HTTPoison.post(auth, [], [{"Authorization", "bearer " <> token}])
  end
end
