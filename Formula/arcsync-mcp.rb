class ArcsyncMcp < Formula
  desc "MCP server giving coding agents ArcSync architecture graphs"
  homepage "https://arcsync.dev/docs/mcp"
  version "0.3.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.1/arcsync-mcp-0.3.1-darwin-arm64.tar.gz"
      sha256 "3ae7803c268023251d1fb29dd214153b8f89ad3c1850c747d95ada7489e92cc0"
    end
    on_intel do
      url "https://registry.npmjs.org/arcsync-mcp/-/arcsync-mcp-0.3.1.tgz"
      sha256 "27b558200874bd811c9b1473e6fce652695b7452c5bf5d3a9414112f041840ea"
      depends_on "node"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.1/arcsync-mcp-0.3.1-linux-arm64.tar.gz"
      sha256 "15d9ef3a713f1c731ca452e03a648fa21b6d6cc79b289dd1b43a144f977160bd"
    end
    on_intel do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.1/arcsync-mcp-0.3.1-linux-x64.tar.gz"
      sha256 "4610233332b6ad3ad1616ddb931a7f6030a319fb45955421b7f505758e1952a9"
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
