{ settings }:
let
  ports = settings.network.ports;
  host = settings.network.host;
in [
  {
    title = "Jellyfin";
    key = "j";
    url = "http://jellyfin.local";
    altUrl = "http://${host}:${toString ports.jellyfin}";
    color = "#AA5CC3";
  }
  {
    title = "Immich";
    key = "i";
    url = "http://photos.local";
    altUrl = "http://${host}:${toString ports.immich}";
    color = "#fa2921";
  }
  {
    title = "Jellyseer";
    key = "l";
    url = "http://jellyseerr.local";
    altUrl = "http://${host}:${toString ports.jellyseerr}";
    color = "#5345e6";
  }
  {
    title = "Radarr";
    key = "r";
    url = "http://radarr.local";
    altUrl = "http://${host}:${toString ports.radarr}";
    color = "#fcbd00";
  }
  {
    title = "Sonarr";
    key = "s";
    url = "http://sonarr.local";
    altUrl = "http://${host}:${toString ports.sonarr}";
    color = "#4c82cf";
  }
  {
    title = "Prowlarr";
    key = "p";
    url = "http://prowlarr.local";
    altUrl = "http://${host}:${toString ports.prowlarr}";
    color = "#ff9a7e";
  }
  {
    title = "Syncthing";
    key = "y";
    url = "http://syncthing.local";
    altUrl = "http://${host}:${toString ports.syncthing}";
    color = "#0891d1";
  }
  {
    title = "Ntfy-sh";
    key = "n";
    url = "http://ntfy.local";
    altUrl = "http://${host}:${toString ports.ntfy}";
    color = "#2dc9b5";
  }
  # {
  #   title = "Grafana";
  #   key = "g";
  #   url = "http://grafana.local";
  #   altUrl = "http://${host}:${toString ports.grafana}";
  #   color = "#f05a28";
  # }
  # {
  #   title = "Send";
  #   key = "f";
  #   url = "http://send.local";
  #   altUrl = "http://${host}:${toString ports.send}";
  #   color = "#0a84ff";
  # }
  {
    title = "News RSS";
    key = "w";
    url = "http://news.local";
    altUrl = "http://${host}:${toString ports.yarr}";
    color = "#475569";
  }
  {
    title = "Lazy Librarian";
    key = "b";
    url = "http://librarian.local";
    altUrl = "http://${host}:${toString ports.lazylibrarian}";
    color = "#55a4db";
  }
]
