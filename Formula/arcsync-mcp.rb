class ArcsyncMcp < Formula
  desc "MCP server giving coding agents ArcSync architecture graphs"
  homepage "https://arcsync.dev/docs/mcp"
  version "0.3.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.2/arcsync-mcp-0.3.2-darwin-arm64.tar.gz"
      sha256 "d130686d57e51eeccc01fa4e9e4baedc87fa468b1678bf7b011adedd900e690f"
    end
    on_intel do
      url "https://registry.npmjs.org/arcsync-mcp/-/arcsync-mcp-0.3.2.tgz"
      sha256 "7de7ede3eb9ff9abb5b239ccd98798fb0f36b75519b666c327ec9a731b0d2a29"
      depends_on "node"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.2/arcsync-mcp-0.3.2-linux-arm64.tar.gz"
      sha256 "c36accbb07c480b830f9cfdf1a01d66fc7fc3d2ca6f6db64fe902ee2a030e32a"
    end
    on_intel do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.2/arcsync-mcp-0.3.2-linux-x64.tar.gz"
      sha256 "eb8d046f1a5f0e07cc9288c865f3851b6eaa9e09ce1508f362e19f5e12c4c1b1"
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
