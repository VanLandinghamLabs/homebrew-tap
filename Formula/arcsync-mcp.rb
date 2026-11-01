class ArcsyncMcp < Formula
  desc "MCP server giving coding agents ArcSync architecture graphs"
  homepage "https://arcsync.dev/docs/mcp"
  version "0.2.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.2.1/arcsync-mcp-0.2.1-darwin-arm64.tar.gz"
      sha256 "7cafff65adcd4f5cf9d5c28e7df6fed0c8d6b2f420f050dd237cacdc171b5f16"
    end
    on_intel do
      url "https://registry.npmjs.org/arcsync-mcp/-/arcsync-mcp-0.2.1.tgz"
      sha256 "554f965820d1c072f87a370ddd3537adb9425232e2f8ace5573202f4f8e47721"
      depends_on "node"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.2.1/arcsync-mcp-0.2.1-linux-arm64.tar.gz"
      sha256 "b8decb042267b292ab20219942b2fa5c117930c5e8a8f0c4896b6411bd9e9b66"
    end
    on_intel do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.2.1/arcsync-mcp-0.2.1-linux-x64.tar.gz"
      sha256 "1fc5ce9ba9d1e3184fc18cb8215388a36b35d435dbceeac7e224693172f79709"
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
