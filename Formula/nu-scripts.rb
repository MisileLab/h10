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

    alias_files = (pkgshare/"aliases").glob("**/*-aliases.nu").sort
    auto_generated_files = (pkgshare/"custom-completions/auto-generate/completions").glob("*.nu").sort
    curated_files = (pkgshare/"custom-completions").glob("**/*-completions.nu").sort

    autoload_lines = [
      "# Autoload nu_scripts aliases and completions.",
      ""
    ]

    (alias_files + auto_generated_files + curated_files).each do |file|
      relative_path = file.relative_path_from(pkgshare)
      autoload_lines << "do --ignore-errors { source \"#{opt_pkgshare}/#{relative_path}\" }"
    end

    (autoload_dir/"nu_scripts.nu").write(autoload_lines.join("\n").concat("\n"))
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
