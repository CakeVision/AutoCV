{
  description = "Kotlin/Wasm development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            # Core tools
            kotlin
            gradle
            jdk17
            
            # Node.js ecosystem
            nodejs_20
            nodePackages.npm
            
            # NixOS compatibility
            patchelf
            stdenv.cc.cc.lib
          ];

          # Environment setup for NixOS
          LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
          
          shellHook = ''
            echo "🚀 Kotlin/Wasm development environment ready!"
            echo "Node.js: $(node --version)"
            echo "NPM: $(npm --version)" 
            echo "Gradle: $(gradle --version | grep Gradle)"
            echo ""
            
            # Configure npm for NixOS
            export npm_config_cache="$HOME/.npm-cache"
            export npm_config_prefix="$HOME/.npm-global"
            mkdir -p "$HOME/.npm-cache" "$HOME/.npm-global"
            
            # Gradle settings
            export GRADLE_OPTS="-Dorg.gradle.daemon=false"
            
            echo "Ready to run: ./gradlew wasmJsBrowserDevelopmentRun"
          '';
        };
      });
}
