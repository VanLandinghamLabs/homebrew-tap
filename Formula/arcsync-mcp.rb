class ArcsyncMcp < Formula
  desc "MCP server giving coding agents ArcSync architecture graphs"
  homepage "https://arcsync.dev/docs/mcp"
  version "0.3.20"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.20/arcsync-mcp-0.3.20-darwin-arm64.tar.gz"
      sha256 "517a9fcb5abae209ef944b4c27c0cd06332daf27f6dd393ae84c554330a356f2"
    end
    on_intel do
      url "https://registry.npmjs.org/arcsync-mcp/-/arcsync-mcp-0.3.20.tgz"
      sha256 "879b0c664ae1b1c2aa63a118d5130dd16700d1e0bf4896de19f2b5959b0d9fad"
      depends_on "node"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.20/arcsync-mcp-0.3.20-linux-arm64.tar.gz"
      sha256 "ae9c7ed8732ccbd0a59bb9e71eca976949a96d34abca367af59a959784c81615"
    end
    on_intel do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.20/arcsync-mcp-0.3.20-linux-x64.tar.gz"
      sha256 "b94d4c5e4ed851c6c81c43213862f7d3e09c377b726d328af875acad86e94919"
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
