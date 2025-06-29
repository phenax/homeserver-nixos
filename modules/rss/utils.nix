{ pkgs, lib, ... }:
with lib;
let
  outlineItem = feed:
    ''<outline title="${feed.title}" text="${feed.title}" xmlUrl="${feed.url}" />'';

  outlineGroup = group: items:
    ''<outline title="${group}" text="${group}">
      ${concatStringsSep "\n" (map outlineItem items)}
    </outline>'';

  toOpml = cfg: ''
<?xml version="1.0" encoding="UTF-8"?>
<opml version="1.1">
  <head>
    <title>
      ${cfg.title}
    </title>
  </head>
  <body>
    ${concatStringsSep "\n" (mapAttrsToList outlineGroup cfg.groups)}
  </body>
</opml>'';

  createYarrSetupScript = { username, api_key, api_url, feeds, settings }:
    let
      api = method: path: args:
        ''curl -i -X${method} '${api_url}${path}' --cookie 'auth=${username}:${api_key}' ${args}'';
      opmlFile = pkgs.writeText "rss.opml" (toOpml feeds);
    in
    pkgs.writeShellScriptBin "yarr-setup-script" ''
      #!/usr/bin/env sh

      ${api "POST" "/opml/import" "-F 'opml=@${opmlFile}' -F 'replace=true'"} && echo "Imported feeds";
      ${api "PUT" "/api/settings" "--data '${builtins.toJSON settings}'"} && echo "Applied settings";
    '';
in {
  inherit toOpml createYarrSetupScript;
}
