{ ... }: {
  programs.firefox = {
    enable = true;
    profiles.nitsky = {
      id = 0;
      name = "nitsky";
      isDefault = true;
      settings = {
        "browser.aboutConfig.showWarning" = false;
        "browser.sessionstore.resume_session_once" = true;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.warnOnQuit" = false;
        "devtools.theme" = "dark";
        "gfx.webrender.all" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.ffmpeg.low-latency.enabled" = true;
        "media.ffvpx.enabled" = false;
        "media.navigator.mediadatadecoder_vpx_enabled" = true;
        "media.rdd-vpx.enabled" = false;
        "security.sandbox.content.level" = 0;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
    };
  };
}
