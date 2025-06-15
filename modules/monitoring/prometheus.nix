{ settings, ... }:
let
  ports = settings.network.ports;
in
{
  services.prometheus = {
    enable = true;
    port = ports.prometheus;

    exporters.node = {
      enable = true;
      port = ports.prometheusNodeExporter;
      enabledCollectors = [ "systemd" ];
      extraFlags = [
        "--collector.ethtool"
        "--collector.softirqs"
        "--collector.tcpstat"
        "--collector.wifi"
      ];
    };

    scrapeConfigs = [
      {
        job_name = "system";
        scrape_interval = "10s";
        static_configs = [{
          targets = [ "127.0.0.1:${toString ports.prometheusNodeExporter}" ];
        }];
      }
    ];
  };
}

