class NuScripts < Formula
  desc "Nushell community scripts, aliases, and completions"
  homepage "https://github.com/nushell/nu_scripts"
  license "MIT"
  head "https://github.com/nushell/nu_scripts.git", branch: "main"

  depends_on "nushell"

  def install
    pkgshare.install Dir["*"]

    autoload_dir = share/"nushell/vendor/autoload"
    autoload_dir.mkpath
    (autoload_dir/"nu_scripts.nu").write <<~EOS
      # Autoload nu_scripts aliases and completions.
      let repo_root = "#{opt_pkgshare}"
      let aliases_dir = ($repo_root | path join "aliases")
      let completions_dir = ($repo_root | path join "custom-completions")

      let alias_files = (
        glob ($aliases_dir | path join "**" "*-aliases.nu")
        | sort
      )

      # Load auto-generated completions first so curated ones override.
      let auto_generated_files = (
        glob ($completions_dir | path join "auto-generate" "completions" "*.nu")
        | sort
      )

      let curated_files = (
        glob ($completions_dir | path join "**" "*-completions.nu")
        | sort
      )

      for file in $alias_files {
        do --ignore-errors { source $file }
      }

      for file in ($auto_generated_files | append $curated_files) {
        do --ignore-errors { source $file }
      }
    EOS
  end

  def caveats
    <<~EOS
      nu_scripts aliases/completions are auto-loaded for Homebrew Nushell.

      If you use a different Nushell build, add this to your config.nu:
        source #{share}/nushell/vendor/autoload/nu_scripts.nu
    EOS
  end

  test do
    assert_path_exists share/"nushell/vendor/autoload/nu_scripts.nu"
  end
end
