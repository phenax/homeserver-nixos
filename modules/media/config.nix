rec {
  mediaBaseDir = "/media";
  downloadsDir = "${mediaBaseDir}/_downloads";
  incompleteDownloadsDir = "${downloadsDir}/_incomplete";

  tvDownloads = "${mediaBaseDir}/tv";
  moviesDownloads = "${mediaBaseDir}/movies";

  radarrPort = 7878;
  sonarrPort = 8989;
  prowlarrPort = 9696;
  jellyfinPort = 8096;

  group = "multimedia";
}
