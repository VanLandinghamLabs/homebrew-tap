class ArcsyncMcp < Formula
  desc "MCP server giving coding agents ArcSync architecture graphs"
  homepage "https://arcsync.dev/docs/mcp"
  version "0.3.19"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.19/arcsync-mcp-0.3.19-darwin-arm64.tar.gz"
      sha256 "84dccf4a11fbec818fb4197f4f58ace57342e4f40b63510d37d9925aedb18dd7"
    end
    on_intel do
      url "https://registry.npmjs.org/arcsync-mcp/-/arcsync-mcp-0.3.19.tgz"
      sha256 "81f99f5c124d69e961e1d74d166e800dd5f0c1a146b15e8abd52b018a918bcac"
      depends_on "node"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.19/arcsync-mcp-0.3.19-linux-arm64.tar.gz"
      sha256 "dfe773cc451c9eab0bf283e18627fa101ca2baea7245cd978756940bde07df70"
    end
    on_intel do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.19/arcsync-mcp-0.3.19-linux-x64.tar.gz"
      sha256 "943ff3c4bf5deabd394b8f902f45a9181303af01b652fe488b9113b9687ce168"
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
