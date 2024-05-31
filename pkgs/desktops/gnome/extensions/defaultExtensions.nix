{ callPackage }:
{
  "system-monitor@gnome-shell-extensions.gcampax.github.com" =
    callPackage ../core/gnome-shell-extensions
      { };
}
