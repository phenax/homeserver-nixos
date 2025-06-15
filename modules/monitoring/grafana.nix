{ settings, ... }:
let
  ports = settings.network.ports;
in
{
  services.grafana = {
    enable = true;
    settings = {
      server = {
        protocol = "http";
        http_addr = "0.0.0.0";
        http_port = ports.grafana;
        domain = "grafana.local";
        serve_from_sub_path = true;
      };
      security = {
        secret_key = settings.grafana.secretKey;
        allow_sign_up = false;
        disable_initial_admin_creation = false;
        disable_gravatar = true;
        admin_user = settings.grafana.adminUser;
        admin_email = settings.grafana.adminEmail;
        admin_password = settings.grafana.adminPassword;
        allow_embedding = true;
      };
    };
  };
}
