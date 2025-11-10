let 
  youtube = id: title: {
    title = "${title}";
    url = "https://www.youtube.com/feeds/videos.xml?channel_id=${id}";
  };
  reddit = subreddit: {
    title = "r/${subreddit}";
    url = "https://www.reddit.com/r/${subreddit}/top/.rss?t=month";
  };
in
{
  title = "Feed reader";

  groups = {
    "Blogs" = [
      { url = "https://rubyonrails.org/feed.xml"; title = "Rails blog"; }
      { url = "https://lexi-lambda.github.io/feeds/all.rss.xml"; title = "Lexi Lambda"; }
      { url = "https://overreacted.io/rss.xml"; title = "Dan Abramov"; }
      { url = "https://tkdodo.eu/blog/rss.xml"; title = "Tkdodo"; }
      { url = "https://kentcdodds.com/blog/rss.xml"; title = "Kent C Dodds"; }
      { url = "https://world.hey.com/dhh/feed.atom"; title = "DHH horseshit"; }
      { url = "https://developer.chrome.com/blog/feed.xml"; title = "Chrome"; }
      { url = "https://programmingisterrible.com/rss"; title = "Programming is terrible"; }
      { url = "https://reacttraining.com/rss.xml"; title = "React Training"; }
      { url = "https://www.developerway.com/rss.xml"; title = "Developer way"; }
      { url = "https://gpanders.com/index.xml"; title = "GPanders (neovim)"; }
      { url = "https://bower.sh/rss"; title = "Bower blog"; }
      { url = "https://developer.mozilla.org/en-US/blog/rss.xml"; title = "MDN blog"; }
      { url = "https://echasnovski.com/blog.xml"; title = "Mini.nvim guy blog"; }
    ];

    "Reddit" = [
      (reddit "dumbphones")
      (reddit "selfhosted")
      (reddit "homeserver")
      (reddit "crafting")
      (reddit "coolguides")
      (reddit "whittling")
      (reddit "psychologymemes")
      (reddit "petthedamndog")
      (reddit "animalsbeingderps")
      (reddit "lifeprotips")
      (reddit "linuxmemes")
    ];

    "Dev news" = [
      { url = "https://bsky.app/profile/did:plc:635xovhsdw27inbgxukm3qtp/rss"; title = "Neovim bsky"; }
      { url = "https://cprss.s3.amazonaws.com/javascriptweekly.com.xml"; title = "JS weekly"; }
      { url = "https://cprss.s3.amazonaws.com/react.statuscode.com.xml"; title = "React status"; }
      { url = "https://www.totaltypescript.com/rss.xml"; title = "Total typescript"; }
      { url = "https://dev.to/feed/tag/haskell"; title = "Haskell - dev.to"; }
      { url = "https://devblogs.microsoft.com/typescript/feed/"; title = "TS announcements"; }
      # { url = "https://news.ycombinator.com/rss"; title = "Hacker news"; }
      { url = "https://mshibanami.github.io/GitHubTrendingRSS/daily/all.xml"; title = "Github trending"; }
      { url = "https://blog.haskell.org/atom.xml"; title = "Haskell news"; }
      { url = "https://this-week-in-rust.org/rss.xml"; title = "Rust weekly"; }
      { url = "https://world.hey.com/this.week.in.rails/feed.atom"; title = "Rails weekly"; }
    ];

    "Linux" = [
      { url = "https://nixos.org/blog/announcements-rss.xml"; title = "Nixos announcements"; }
      { url = "https://www.cyberciti.com/feed/"; title = "Cyberciti news"; }
      { url = "https://itsfoss.com/rss/"; title = "Its FOSS"; }
    ];

    "Neovim" = [
      { url = "https://dotfyle.com/this-week-in-neovim/rss.xml"; title = "This week in neovim"; }
      { url = "https://dotfyle.com/neovim/plugins/rss.xml"; title = "New plugins"; }
      { url = "https://vimtricks.com/feed/"; title = "Vimtricks"; }
      (reddit "neovim")
    ];

    "Youtube" = [
      (youtube "UCJswRv22oiUgmT1FuFeUekw" "IamMoBo")
      (youtube "UCSb_Sui6FBxVS4_ROsrU_Iw" "NaturalHabitatShorts")
      (youtube "UCR1D15p_vdP3HkrH8wgjQRw" "InternetHistorian")
      (youtube "UC8Q7XEy86Q7T-3kNpNjYgwA" "Incognito Mode")
      (youtube "UCW7AGm8JSBEEew61dJIgl_A" "Tom Cardy")
      (youtube "UCh9IfI45mmk59eDvSWtuuhQ" "Ryan George")
      (youtube "UCM15YNy8g-CaJ15YZCbq0Iw" "North of the border")
      (youtube "UC-lHJZR3Gqxm24_Vd_AJ5Yw" "Pewdiepie")

      (youtube "UCUMwY9iS8oMyWDYIe6_RmoA" "No boilerplate")
      (youtube "UCo71RUe6DX4w-Vd47rFLXPg" "TypeCraft")
      (youtube "UCswG6FSbgZjbWtdf_hMLaow" "TS: Matt Pocock")
      (youtube "UCWQaM7SpSECp9FELz-cHzuQ" "Dreams of code")
      (youtube "UCjr2bPAyPV7t35MvcgT3W8Q" "The Hated One")

      (youtube "UCimiUgDLbi6P17BdaCZpVbg" "exurb1a")
      (youtube "UCr3cBLTYmIK9kY0F_OdFWFQ" "Casually Explained")
      (youtube "UCYO_jab_esuFRV4b17AJtAw" "3Blue 1Brown")
      (youtube "UCHnyfMqiRRG1u-2MsSQLbXA" "Veritasium")
      (youtube "UCsXVk37bltHxD1rDPwtNM8Q" "Kurzgesagt")
      (youtube "UC6nSFpj9HTCZ5t-N3Rm3-HA" "Vsauce")
    ];

    "Others" = [
      { url = "https://xkcd.com/rss.xml"; title = "xkcd"; }
    ];
  };
}
