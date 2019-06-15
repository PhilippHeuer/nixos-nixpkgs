{ lib, config }:

let
  fpmCfg = config.services.phpfpm;
in

with lib; {

  options = {

    socketName = mkOption {
      type = types.str;
      example = "php-fpm";
      description = ''
        The address on which to accept FastCGI requests.
      '';
    };

    phpPackage = mkOption {
      type = types.package;
      default = fpmCfg.phpPackage;
      defaultText = "config.services.phpfpm.phpPackage";
      description = ''
        The PHP package to use for running this PHP-FPM pool.
      '';
    };

    phpOptions = mkOption {
      type = types.lines;
      default = fpmCfg.phpOptions;
      defaultText = "config.services.phpfpm.phpOptions";
      description = ''
        "Options appended to the PHP configuration file <filename>php.ini</filename> used for this PHP-FPM pool."
      '';
    };

    user = mkOption {
      type = types.string;
      default = "phpfpm";
      description = "User account under which phpfpm runs.";
    };

    group = mkOption {
      type = types.string;
      default = "phpfpm";
      description = "Group account under which phpfpm runs.";
    };

    extraConfig = mkOption {
      type = types.lines;
      example = ''
        pm = dynamic
        pm.max_children = 75
        pm.start_servers = 10
        pm.min_spare_servers = 5
        pm.max_spare_servers = 20
        pm.max_requests = 500
      '';

      description = ''
        Extra lines that go into the pool configuration.
        See the documentation on <literal>php-fpm.conf</literal> for
        details on configuration directives.
      '';
    };
  };
}

