class Packwiz < Formula
  desc "Command-line tool for creating Minecraft modpacks"
  homepage "https://packwiz.infra.link/"
  url "https://github.com/packwiz/packwiz/archive/52b123018f9e19b49703f76e78ad415642acf5c5.tar.gz"
  sha256 "f800ae8301ed894c80e9b0eb55994791857e5490a27e43828a773afd7c1b6afa"
  version "2025.11.24"
  license "MIT"
  head "https://github.com/packwiz/packwiz.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end

  test do
    system bin/"packwiz", "--help"
  end
end
