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
      prowlarr = 9696;
      jellyfin = 8096;
      transmissionRPC = 9091;
    };
    exposeTransmissionRPC = false;
  };

  media = {
    baseDir = "/media";
    downloadsDir = "${media.baseDir}/_downloads";
    tvDir = "${media.baseDir}/tv";
    moviesDir = "${media.baseDir}/movies";
    group = "multimedia";
  };
}
