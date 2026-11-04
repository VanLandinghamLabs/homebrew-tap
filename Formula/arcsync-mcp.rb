class ArcsyncMcp < Formula
  desc "MCP server giving coding agents ArcSync architecture graphs"
  homepage "https://arcsync.dev/docs/mcp"
  version "0.3.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.4/arcsync-mcp-0.3.4-darwin-arm64.tar.gz"
      sha256 "6ae1f0ae2c21bd09ebc1f1e94b25ccf8a2359a9413f6bee38e535b9f35f0ee11"
    end
    on_intel do
      url "https://registry.npmjs.org/arcsync-mcp/-/arcsync-mcp-0.3.4.tgz"
      sha256 "1656814ce365fd807eec51ae2154e8595bdf506a04032e4a6795d7da777aca3f"
      depends_on "node"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.4/arcsync-mcp-0.3.4-linux-arm64.tar.gz"
      sha256 "044d476d36276d4f01c8d0adbe6cff22232d62c2069f33987d6a1c6c9c1490f8"
    end
    on_intel do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.4/arcsync-mcp-0.3.4-linux-x64.tar.gz"
      sha256 "9cec202fac2392a6af452aa1f33f0bd1a7c9625fcdf369a973fa4d4b69ea29b7"
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
