class ArcsyncMcp < Formula
  desc "MCP server giving coding agents ArcSync architecture graphs"
  homepage "https://arcsync.dev/docs/mcp"
  version "0.3.5"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.5/arcsync-mcp-0.3.5-darwin-arm64.tar.gz"
      sha256 "35504b59e01f03ccecd3b178df4a0b2f7d670a763f2f48b3a512c4637b299570"
    end
    on_intel do
      url "https://registry.npmjs.org/arcsync-mcp/-/arcsync-mcp-0.3.5.tgz"
      sha256 "b81f49d508bc7468e59f7924846c31254fa1ccc3374992f2a672ea75b989fb08"
      depends_on "node"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.5/arcsync-mcp-0.3.5-linux-arm64.tar.gz"
      sha256 "dc9f3fd49df15ce459123d4743bdd5769e3437de599fda7002fc1a73d7ec1f67"
    end
    on_intel do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.5/arcsync-mcp-0.3.5-linux-x64.tar.gz"
      sha256 "8a0ba7d8181af1c660aaf799e599e7f541e5fadb4a9321a8e74901faf8699089"
    end
  end

  def install
    if OS.mac? && Hardware::CPU.intel?
      system "npm", "install", *std_npm_args
      bin.install_symlink libexec.glob("bin/*")
    else
      bin.install "arcsync-mcp"
    end
  end

  test do
    request = '{"jsonrpc":"2.0","id":1,"method":"initialize","params":' \
              '{"protocolVersion":"2025-06-18","capabilities":{},"clientInfo":{"name":"brew","version":"0"}}}'
    assert_match '"name":"arcsync"', pipe_output(bin/"arcsync-mcp", "#{request}\n", 0)
  end
end
