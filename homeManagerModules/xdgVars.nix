{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.xdgVars;

  vars = cfg.variables;

  varsT = types.submodule {
    options = {
      cache = mkOption {type = types.nonEmptyStr;};
      config = mkOption {type = types.nonEmptyStr;};
      data = mkOption {type = types.nonEmptyStr;};
      state = mkOption {type = types.nonEmptyStr;};
      runtime = mkOption {type = types.nonEmptyStr;};
    };
  };
in {
  options.xdgVars = {
    enable = mkEnableOption "Variables that make programs XDG-compliant";

    variables = mkOption {type = varsT;};
  };

  config = mkIf cfg.enable {
    home.sessionVariables = {
      ACKRC = "${vars.config}/ack/ackrc";
      ANDROID_HOME = "${vars.data}/android";
      ANDROID_USER_HOME = "${vars.data}/android";
      ANSIBLE_CONFIG = "${vars.config}/ansible.cfg";
      ANSIBLE_GALAXY_CACHE_DIR = "${vars.cache}/ansible/galaxy_cache";
      ANSIBLE_HOME = "${vars.config}/ansible";
      ASDF_CONFIG_FILE = "${vars.config}/asdf/asdfrc";
      ASDF_DATA_DIR = "${vars.data}/asdf";
      ASPELL_CONF = "per-conf ${vars.config}/aspell/aspell.conf; personal ${vars.data}/aspell/en.pws; repl ${vars.data}/aspell/en.prepl";
      AWS_CONFIG_FILE = "${vars.config}/aws/config";
      AWS_SHARED_CREDENTIALS_FILE = "${vars.config}/aws/credentials";
      AZURE_CONFIG_DIR = "${vars.data}/azure";
      BASH_COMPLETION_USER_FILE = "${vars.config}/bash-completion/bash_completion";
      BOGOFILTER_DIR = "${vars.data}/bogofilter";
      C3270PRO = "${vars.config}/c3270/config";
      CALCHISTFILE = "${vars.cache}/calc_history";
      CARGO_HOME = "${vars.data}/cargo";
      CD_BOOKMARK_FILE = "${vars.config}/cd-bookmark/bookmarks";
      CGDB_DIR = "${vars.config}/cgdb";
      CHKTEXRC = "${vars.config}/chktex";
      CIN_CONFIG = "${vars.config}/bcast5";
      CONAN_USER_HOME = "${vars.config}";
      CRAWL_DIR = "${vars.data}/crawl/";
      CUDA_CACHE_PATH = "${vars.cache}/nv";
      DISCORD_USER_DATA_DIR = "${vars.data}";
      DOCKER_CONFIG = "${vars.config}/docker";
      DOT_SAGE = "${vars.config}/sage";
      DUB_HOME = "${vars.config}/dub";
      DVDCSS_CACHE = "${vars.cache}/dvdcss";
      EASYOCR_MODULE_PATH = "${vars.config}/EasyOCR";
      ELECTRUMDIR = "${vars.data}/electrum";
      ELINKS_CONFDIR = "${vars.config}/elinks";
      ELM_HOME = "${vars.config}/elm";
      EM_CACHE = "${vars.cache}/emscripten/cache";
      EM_CONFIG = "${vars.config}/emscripten/config";
      EM_PORTS = "${vars.data}/emscripten/cache";
      FCEUX_HOME = "${vars.config}/fceux";
      FFMPEG_DATADIR = "${vars.config}/ffmpeg";
      GETIPLAYERUSERPREFS = "${vars.data}/get_iplayer";
      GHCUP_USE_XDG_DIRS = "true";
      GNUPGHOME = "${vars.data}/gnupg";
      GOMODCACHE = "${vars.cache}/go/mod";
      GOPATH = "${vars.data}/go";
      GQRC = "${vars.config}/gqrc";
      GQSTATE = "${vars.data}/gq/gq-state";
      GRADLE_USER_HOME = "${vars.data}/gradle";
      GRC_PREFS_PATH = "${vars.config}/gnuradio/grc.conf";
      GRIPHOME = "${vars.config}/grip";
      GR_PREFS_PATH = "${vars.config}/gnuradio";
      GTK2_RC_FILES = "${vars.config}/gtk-2.0/gtkrc";
      GTK_RC_FILES = "${vars.config}/gtk-1.0/gtkrc";
      HISTFILE = "${vars.state}/bash/history";
      HOUDINI_USER_PREF_DIR = "${vars.cache}/houdini__HVER__";
      ICEAUTHORITY = "${vars.cache}/ICEauthority";
      IMAPFILTER_HOME = "${vars.config}/imapfilter";
      INPUTRC = "${vars.config}/readline/inputrc";
      IPFS_PATH = "${vars.data}/ipfs";
      IRBRC = "${vars.config}/irb/irbrc";
      _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=${vars.config}/java -Djavafx.cachedir=${vars.cache}/openjfx";
      JULIA_DEPOT_PATH = "${vars.data}/julia:$JULIA_DEPOT_PATH";
      JULIAUP_DEPOT_PATH = "${vars.data}/julia";
      JUPYTER_PLATFORM_DIRS = "1";
      K9SCONFIG = "${vars.config}/k9s";
      KODI_DATA = "${vars.data}/kodi";
      KSCRIPT_CACHE_DIR = "${vars.cache}/kscript";
      KUBECACHEDIR = "${vars.cache}/kube";
      KUBECONFIG = "${vars.config}/kube";
      LEDGER_FILE = "${vars.data}/hledger.journal";
      LEIN_HOME = "${vars.data}/lein";
      LYNX_CFG_PATH = "${vars.config}/lynx.cfg";
      MACHINE_STORAGE_PATH = "${vars.data}/docker-machine";
      MATHEMATICA_USERBASE = "${vars.config}/mathematica";
      MAXIMA_USERDIR = "${vars.config}/maxima";
      MEDNAFEN_HOME = "${vars.config}/mednafen";
      MINIKUBE_HOME = "${vars.data}/minikube";
      MIX_XDG = "true";
      MOST_INITFILE = "${vars.config}/mostrc";
      MPLAYER_HOME = "${vars.config}/mplayer";
      MYPY_CACHE_DIR = "${vars.cache}/mypy";
      MYSQL_HISTFILE = "${vars.data}/mysql_history";
      NODENV_ROOT = "${vars.data}/nodenv";
      NODE_REPL_HISTORY = "${vars.data}/node_repl_history";
      NPM_CONFIG_USERCONFIG = "${vars.config}/npm/npmrc";
      N_PREFIX = "${vars.data}/n";
      NUGET_PACKAGES = "${vars.cache}/NuGetPackages";
      NVM_DIR = "${vars.data}/nvm";
      OCTAVE_HISTFILE = "${vars.cache}/octave-hsts";
      OLLAMA_MODELS = "${vars.data}/ollama/models";
      OMNISHARPHOME = "${vars.config}/omnisharp";
      OPAMROOT = "${vars.data}/opam";
      PARALLEL_HOME = "${vars.config}/parallel";
      PASSWORD_STORE_DIR = "${vars.data}/pass";
      PGPASSFILE = "${vars.config}/pg/pgpass";
      PGSERVICEFILE = "${vars.config}/pg/pg_service.conf";
      PLATFORMIO_CORE_DIR = "${vars.data}/platformio";
      PLTUSERHOME = "${vars.data}/racket";
      PSQL_HISTORY = "${vars.state}/psql_history";
      PSQLRC = "${vars.config}/pg/psqlrc";
      PYENV_ROOT = "${vars.data}/pyenv";
      PYLINTHOME = "${vars.cache}/pylint";
      PYLINTRC = "${vars.config}/pylint/pylintrc";
      PYTHON_EGG_CACHE = "${vars.cache}/python-eggs";
      PYTHON_HISTORY = "${vars.state}/python/history";
      PYTHONPYCACHEPREFIX = "${vars.cache}/python";
      PYTHONUSERBASE = "${vars.data}/python";
      RBENV_ROOT = "${vars.data}/rbenv";
      RECOLL_CONFDIR = "${vars.config}/recoll";
      REDISCLI_HISTFILE = "${vars.data}/redis/rediscli_history";
      REDISCLI_RCFILE = "${vars.config}/redis/redisclirc";
      RIPGREP_CONFIG_PATH = "${vars.config}/ripgrep/config";
      RLWRAP_HOME = "${vars.data}/rlwrap";
      RUFF_CACHE_DIR = "${vars.cache}/ruff";
      RUSTUP_HOME = "${vars.data}/rustup";
      RXVT_SOCKET = "${vars.runtime}/urxvtd";
      SCREENRC = "${vars.config}}/screen/screenrc";
      SINGULARITY_CACHEDIR = "${vars.cache}/singularity";
      SINGULARITY_CONFIGDIR = "${vars.config}/singularity";
      SOLARGRAPH_CACHE = "${vars.cache}/solargraph";
      SPACEMACSDIR = "${vars.config}/spacemacs";
      SQLITE_HISTORY = "${vars.data}/sqlite_history";
      STACK_XDG = "1";
      TERMINFO = "${vars.data}/terminfo";
      TERMINFO_DIRS = "${vars.data}/terminfo:/usr/share/terminfo";
      TEXMACS_HOME_PATH = "${vars.state}/texmacs";
      TEXMFCONFIG = "${vars.config}/texlive/texmf-config";
      TEXMFHOME = "${vars.data}/texmf";
      TEXMFVAR = "${vars.cache}/texlive/texmf-var";
      TRAVIS_CONFIG_PATH = "${vars.config}/travis";
      TS3_CONFIG_DIR = "${vars.config}/ts3client";
      UNCRUSTIFY_CONFIG = "${vars.config}/uncrustify/uncrustify.cfg";
      UNISON = "${vars.data}/unison";
      VAGRANT_ALIAS_FILE = "${vars.data}/vagrant/aliases";
      VAGRANT_HOME = "${vars.data}/vagrant";
      VIMPERATOR_INIT = ":source ${vars.config}/vimperator/vimperatorrc";
      VIMPERATOR_RUNTIME = "${vars.config}/vimperator";
      W3M_DIR = "${vars.state}/w3m";
      WAKATIME_HOME = "${vars.config}/wakatime";
      WGETRC = "${vars.config}/wgetrc";
      WINEPREFIX = "${vars.data}/wineprefixes/default";
      WORKON_HOME = "${vars.data}/virtualenvs";
      X3270PRO = "${vars.config}/x3270/config";
      XCOMPOSECACHE = "${vars.cache}/X11/xcompose";
      XCOMPOSEFILE = "${vars.config}/X11/xcompose";
      XINITRC = "${vars.config}/X11/xinitrc";
      XSERVERRC = "${vars.config}/X11/xserverrc";
      _Z_DATA = "${vars.data}/z";
    };

    xdg.configFile."npm/npmrc".text = ''
      prefix=${vars.data}/npm
      cache=${vars.cache}/npm
      init-module=${vars.config}/npm/config/npm-init.js
      logs-dir=${vars.state}/npm/logs

      store-dir=${vars.data}/pnpm-store
    '';

    xdg.configFile."wgetrc".text = "hsts-file = ${vars.cache}/wget-hsts";
  };
}
