# Homebrew formula for AgentCarousel (Rust CLI).
#
# Maintainer checklist when releasing a new version:
# 1. Tag the repo (e.g. v0.5.0) and push the tag.
# 2. Update `url` to the matching archive URL.
# 3. Refresh `sha256`:
#      curl -fsSL "<url>" | shasum -a 256
# 4. Test locally:
#      brew install --build-from-source ./packaging/homebrew/agentcarousel.rb
#      brew test ./packaging/homebrew/agentcarousel.rb
#      brew audit --strict --new ./packaging/homebrew/agentcarousel.rb
# 5. Submit to homebrew-core, or copy into a tap repo (e.g. agentcarousel/homebrew-tap).

class Agentcarousel < Formula
  desc "CLI to validate, test, and evaluate AI agent fixtures"
  homepage "https://agentcarousel.com"
  url "https://github.com/agentcarousel/agentcarousel/archive/refs/tags/v0.5.3.tar.gz"
  sha256 "cfc511fc32e6de04e57ae7bbfd95f0206dc99d7988a9d8848b52152067af5ede"
  license "Apache-2.0"
  head "https://github.com/agentcarousel/agentcarousel.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/agentcarousel")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/agentcarousel --version")
    assert_match version.to_s, shell_output("#{bin}/agc --version")
  end
end
