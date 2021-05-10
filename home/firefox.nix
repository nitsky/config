user:
{ pkgs, ... }: {
  programs.firefox = {
    enable = true;
    profiles.${user.username} = {
      id = 0;
      name = user.username;
      isDefault = true;
      settings = {
        "browser.aboutConfig.showWarning" = false;
        "browser.newtabpage.activity-stream.feeds.section.highlights" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.snippets" = false;
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.showSearch" = false;
        "browser.sessionstore.resume_session_once" = true;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.warnOnQuit" = false;
        "devtools.theme" = "dark";
        "gfx.webrender.all" = true;
        "media.ffmpeg.low-latency.enabled" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.ffvpx.enabled" = false;
        "media.navigator.mediadatadecoder_vpx_enabled" = true;
        "media.rdd-vpx.enabled" = false;
        "security.sandbox.content.level" = 0;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
    };
  };
}
