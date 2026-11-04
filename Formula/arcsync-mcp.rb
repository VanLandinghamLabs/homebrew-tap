class ArcsyncMcp < Formula
  desc "MCP server giving coding agents ArcSync architecture graphs"
  homepage "https://arcsync.dev/docs/mcp"
  version "0.3.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.3/arcsync-mcp-0.3.3-darwin-arm64.tar.gz"
      sha256 "33a43f7ed41ec588e4534836f216f36001a481e10cb1bf9f7e77c02fc056f04a"
    end
    on_intel do
      url "https://registry.npmjs.org/arcsync-mcp/-/arcsync-mcp-0.3.3.tgz"
      sha256 "c1d1022c700d532da6322f7cbeeb6c7a2f401f30541518da51f6e4fb269f97e9"
      depends_on "node"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.3/arcsync-mcp-0.3.3-linux-arm64.tar.gz"
      sha256 "b764447cc8e6c87703c3b23c408ba8f382b470d214c8d629693ceeea934a16c3"
    end
    on_intel do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.3/arcsync-mcp-0.3.3-linux-x64.tar.gz"
      sha256 "af3537d56861d3e4e09dc171d81f322b44db94360fb501309ef406c430886ffa"
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
