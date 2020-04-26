{ stdenv, fetchurl, lib }:

let
  commit = "5955bc4cabe8bdfa0c6b5f5ecfbe23df6e5560c1";
  mkScript = name: script:
    with script;
    stdenv.mkDerivation {
      inherit (script) version;

      pname = "weechat-${name}";

      src = fetchurl {
        url = "https://raw.githubusercontent.com/weechat/scripts/${commit}/${lang}/${fname}";
        inherit (script) sha256;
      };

      passthru.scripts = [ fname ];
      unpackPhase = ":";
      installPhase = ''
        install -D $src $out/share/${fname}
      '';

      meta = with stdenv.lib; {
        inherit (script) description license;
        homepage = "https://weechat.org/scripts/";
        maintainers = with maintainers; [ dominikh ];
      };
    };

  scripts = {
    colorize-nicks = {
      version = "26";
      lang = "python";
      fname = "colorize_nicks.py";
      sha256 = "1ldk6q4yhwgf1b8iizr971vqd9af6cz7f3krd3xw99wd1kjqqbx5";
      description = "This script colors nicks in IRC channels in the actual message not just in the prefix section.";
      license = lib.licenses.gpl3;
    };

    highmon = {
      version = "2.6";
      lang = "perl";
      fname = "highmon.pl";
      sha256 = "0bjdsck2mdshm8gxa7agpkhyv47wngcspcn8z0dv50a0mnvzp4gb";
      description = "Add 'Highlight Monitor' buffer/bar to log all highlights in one spot";
      license = lib.licenses.gpl3;
    };

    autojoin = {
      version = "0.3.1";
      lang = "python";
      fname = "autojoin.py";
      sha256 = "10y71ciiankinwi83b19fj8452vxgi1hasnwca64l0lrjgmbnrai";
      description = "Configure autojoin for all servers according to currently joined channels";
      license = lib.licenses.gpl3;
    };

    go = {
      version = "2.6";
      lang = "python";
      fname = "go.py";
      sha256 = "0zgy1dgkzlqjc0jzbdwa21yfcnvlwx154rlzll4c75c1y5825mld";
      description = "Quick jump to buffers";
      license = lib.licenses.gpl3;
    };

    whois-on-query = {
      version = "0.6.1";
      lang = "python";
      fname = "whois_on_query.py";
      sha256 = "1rcpl7apx0063vv1743fg77x56irxgn8kl5hqb03m0jhn0ss4pky";
      description = ''Send "whois" on nick when receiving (or opening) new IRC query.'';
      license = lib.licenses.gpl3;
    };
  };
in lib.attrsets.mapAttrs (name: value: mkScript name value) scripts
