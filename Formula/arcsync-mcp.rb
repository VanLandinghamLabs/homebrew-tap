class ArcsyncMcp < Formula
  desc "MCP server giving coding agents ArcSync architecture graphs"
  homepage "https://arcsync.dev/docs/mcp"
  version "0.3.14"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.14/arcsync-mcp-0.3.14-darwin-arm64.tar.gz"
      sha256 "d5f4e5845c19402564905350a30115522dfb875e971c765a9aaa183e04976cad"
    end
    on_intel do
      url "https://registry.npmjs.org/arcsync-mcp/-/arcsync-mcp-0.3.14.tgz"
      sha256 "b91b2adfb52d5f2aae0b78f3b37ca3d5aed94e49cdf1de035646204321cdd2fa"
      depends_on "node"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.14/arcsync-mcp-0.3.14-linux-arm64.tar.gz"
      sha256 "8cbd1ffeb83c238302d98b5ef8064fc5dd6863ec84e499e49ac41c4a80ba4a10"
    end
    on_intel do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.14/arcsync-mcp-0.3.14-linux-x64.tar.gz"
      sha256 "be3d66d5a1b1a79467b0ce68a6421b74b806516a0e80fca1ecddcc359207bf0f"
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
