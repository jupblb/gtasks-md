{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url     = "github:NixOS/nixpkgs/release-25.05";
  };

  outputs = { self, flake-utils, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        dependencies   = python3Packages: with python3Packages; [
          google-api-python-client
          google-auth-httplib2
          google-auth-oauthlib
          python-pandoc
          xdg
        ];
        pkgs           = (import nixpkgs) { inherit system; };
        python-pandoc  = with pkgs.python3Packages; buildPythonPackage rec {
          pname                 = "pandoc";
          propagatedBuildInputs = [ plumbum ply ];
          src                   = fetchPypi {
            inherit pname version;
            sha256 = "sha256-7NH4y7f0GAxrXbShenwadN9RmZX18Ybvgc5yqcvQ3Zo=";
          };
          version               = "2.4";
        };
        pythonWithPkgs = pkgs.python3.withPackages(dependencies);
      in {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs;
            [ gh pandoc pyright pythonWithPkgs ruff ];
          shellHook   = ''
            PYTHONPATH=${pythonWithPkgs}/${pythonWithPkgs.sitePackages}
          '';
        };

        packages = {
          gtasks-md = pkgs.python3Packages.buildPythonApplication {
            format                = "pyproject";
            nativeBuildInputs     = with pkgs.python3Packages;
              [ setuptools wheel ];
            pname                 = "gtasks-md";
            propagatedBuildInputs = dependencies(pkgs.python3Packages);
            src                   = self;
            version               = "0.0.10";
          };
        };
      }
    );
}
