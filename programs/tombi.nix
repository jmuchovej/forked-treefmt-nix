{
  lib,
  config,
  mkFormatterModule,
  ...
}:
let
  cfg = config.programs.tombi;
in
{
  meta.maintainers = [ ];

  imports = [
    (mkFormatterModule {
      name = "tombi";
      args = [ "format" ];
      includes = [ "*.toml" ];
    })
  ];

  options.programs.tombi = {
    offline = lib.mkEnableOption "offline mode, disabling network access for remote schemas";
  };

  config = lib.mkIf cfg.enable {
    settings.formatter.tombi = {
      options = lib.optional cfg.offline "--offline";
    };
  };
}
