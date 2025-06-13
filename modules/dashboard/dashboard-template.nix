{ title, links ? [], embedLink ? null, ... }:
with builtins;
let
  withLinkAttr = link: attr: def: value:
    if hasAttr attr link then value else def;

  linkHTML = link: ''
    <a href="${link.url}" class="card" style="${withLinkAttr link "color" "" "--color-card-accent: ${link.color}"}">
      ${link.title} ${if hasAttr "key" link then "(${link.key})" else ""}
      <div class="card-link">${link.url}</div>
      ${if hasAttr "altUrl" link then ''<div class="card-link">(Alt: ${link.altUrl})</div>'' else ""}
    </a>
  '';

  script = ''
    window.addEventListener('keydown', (event) => {
      const noMod = !event.ctrlKey && !event.altKey;
      ${concatStringsSep "\n" (map (link:
        withLinkAttr link "key" "" ''
          if (event.key.toLowerCase() == ${toJSON link.key} && noMod) {
            event.preventDefault();
            if (event.shiftKey)
              window.open(${toJSON link.url});
            else
              window.location.href = ${toJSON link.url};
            return;
          }
        ''
      ) links)}
    });
  '';

  styles = ''
    :root {
      font-size: 16px;
      color: #dbe0f9;
      font-family: JetBrains Mono, monospace;
    }
    html, body {
      background-color: #0f0c19;
      padding: 0;
      margin: 0;
    }
    body * { box-sizing: border-box; }
    header {
      padding: 1rem 2rem;
      background-color: #000;
    }
    .links-container {
      display: grid;
      gap: 1rem;
      grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
      padding: 0 1rem;
      width: 100%;
      margin: 1rem auto 2rem;
      max-width: 1200px
    }
    .card {
      --color-card-accent: #8e7ae3;
      display: block;
      padding: 1rem 1.5rem;
      font-size: 1.2rem;
      color: var(--color-card-accent);
      text-decoration: none;
      border: 2px solid #1a1824;
      position: relative;
    }
    .card::before {
      content: " ";
      position: absolute;
      left: 0; top: 0;
      width: 4px; height: 100%;
      background-color: var(--color-card-accent);
    }
    .card:hover {
      border-color: var(--color-card-accent);
      background-color: rgba(255,255,255,0.05);
    }
    .card:focus {
      border-color: var(--color-card-accent);
      outline: none;
    }
    .card-link {
      font-size: 0.5em;
      padding-top: 1em;
      color: gray;
    }
    button {
      background: none;
      padding: 0;
      text-decoration: underline;
      color: gray;
      margin: 0;
      border: 0;
    }
    .stats-container {
      padding: 1rem;
      border-top: 1px solid #1a1824;
    }
    .stats-container iframe {
      width: 100%;
      display: block;
      min-height: 1100px;
      height: 100%;
      border: 2px solid #1a1824;
      border-radius: 5px;
    }
  '';

  headerHTML = ''
    <header>${title}</header>
  '';
in
''
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${title}</title>
    <style>${styles}</style>
  </head>
  <body>
    ${headerHTML}
    <section class="links-container">
      ${concatStringsSep "" (map linkHTML links)}
    </section>
    ${if embedLink == null then "" else ''
      <section class="stats-container">
        <iframe src="${embedLink}"></iframe>
      </section>
    ''}
    <script>${script}</script>
  </body>
</html>
''
