class ArcsyncMcp < Formula
  desc "MCP server giving coding agents ArcSync architecture graphs"
  homepage "https://arcsync.dev/docs/mcp"
  version "0.3.13"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.13/arcsync-mcp-0.3.13-darwin-arm64.tar.gz"
      sha256 "1195e37e91bcb8794e29be9229f5614da18a38fe34b5ea7fecf6f6044fa2c431"
    end
    on_intel do
      url "https://registry.npmjs.org/arcsync-mcp/-/arcsync-mcp-0.3.13.tgz"
      sha256 "e90572566283dd74346096a829f769aa0fecc14aa59ced28dca441fad30e934e"
      depends_on "node"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.13/arcsync-mcp-0.3.13-linux-arm64.tar.gz"
      sha256 "98bd462faed9262909b9373353a32af1132f828db7942834e192f76124918ba3"
    end
    on_intel do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.13/arcsync-mcp-0.3.13-linux-x64.tar.gz"
      sha256 "981c5020cec56a8fa6dafc273c559b83439c02bc9e7a9eb45cf667e1ec74650b"
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
