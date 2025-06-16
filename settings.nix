{ lib }:
let
  privateSettings = import ./settings.private.nix;
in lib.recursiveUpdate privateSettings rec {
  network = {
    ports = {
      dashboard = 80;
      ssh = 22;
      radarr = 7878;
      sonarr = 8989;
      lidarr = 8686;
      prowlarr = 9696;
      jellyfin = 8096;
      jellyseerr = 5055;
      transmissionRPC = 9091;
      syncthing = 3141;
      ntfy = 3142;
      grafana = 3143;
      prometheus = 9001;
      prometheusNodeExporter = 9002;
      send = 1443;
      immich = 3144;
    };
    exposeTransmissionRPC = false;
  };

  git = {
    baseDir = "/git";
    group = "git";
  };

  immich = {
    baseDir = "/media/_immich";
    user = "immich";
    group = "immich";
  };

  syncthing = {
    baseDir = "/media/syncthing";
    photosDir = "${syncthing.baseDir}/photos";
    group = "syncthing";
  };

  media = rec {
    baseDir = "/media";
    downloadsDir = "${baseDir}/_downloads";
    tvDir = "${baseDir}/tv";
    moviesDir = "${baseDir}/movies";
    musicDir = "${baseDir}/music";
    group = "multimedia";
  };
}
