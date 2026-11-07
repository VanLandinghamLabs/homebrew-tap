class ArcsyncMcp < Formula
  desc "MCP server giving coding agents ArcSync architecture graphs"
  homepage "https://arcsync.dev/docs/mcp"
  version "0.3.8"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.8/arcsync-mcp-0.3.8-darwin-arm64.tar.gz"
      sha256 "8fb519b57834be446f1958f256f2fb202e4343650798a0eeb25169efd5ca9332"
    end
    on_intel do
      url "https://registry.npmjs.org/arcsync-mcp/-/arcsync-mcp-0.3.8.tgz"
      sha256 "da6ba7972059fe8c05ac032c6499d0783e479fe1fdfa15907b695c99b0ec9b35"
      depends_on "node"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.8/arcsync-mcp-0.3.8-linux-arm64.tar.gz"
      sha256 "b2fc912aa40f29ad113b790dc9ac0dda640df45e8691384073a530eae6001714"
    end
    on_intel do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.8/arcsync-mcp-0.3.8-linux-x64.tar.gz"
      sha256 "1e4d5943d6487b61d0a74289d48e825e3effe1af1f9c8f8b76c75602e73903fd"
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
