class ArcsyncMcp < Formula
  desc "MCP server giving coding agents ArcSync architecture graphs"
  homepage "https://arcsync.dev/docs/mcp"
  version "0.3.11"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.11/arcsync-mcp-0.3.11-darwin-arm64.tar.gz"
      sha256 "1f0fe63492a1d96637a24b7ebb47a04ba58544c7f666b74284efa8fc2ee36e57"
    end
    on_intel do
      url "https://registry.npmjs.org/arcsync-mcp/-/arcsync-mcp-0.3.11.tgz"
      sha256 "cd72f28643e9ae10ec17fb99cfd0447fc86d41d11535f6e6c26f395c31e1b5a3"
      depends_on "node"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.11/arcsync-mcp-0.3.11-linux-arm64.tar.gz"
      sha256 "0c40f9ee51961104435ca96ab01a02017fcc15fb96ead4552f5c1f0c0ccaa822"
    end
    on_intel do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.11/arcsync-mcp-0.3.11-linux-x64.tar.gz"
      sha256 "0214b813d76e4f9243881a862f3fbecafe182cf98aa426513a7028f8d2967f44"
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
