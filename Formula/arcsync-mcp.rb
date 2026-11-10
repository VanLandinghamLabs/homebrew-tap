class ArcsyncMcp < Formula
  desc "MCP server giving coding agents ArcSync architecture graphs"
  homepage "https://arcsync.dev/docs/mcp"
  version "0.3.10"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.10/arcsync-mcp-0.3.10-darwin-arm64.tar.gz"
      sha256 "4c4564f5bac5e60adbcacb0df34b3d562a0a77d245d3886627da7190e6ecdf54"
    end
    on_intel do
      url "https://registry.npmjs.org/arcsync-mcp/-/arcsync-mcp-0.3.10.tgz"
      sha256 "4af83911e7497b6c5d648c753534fee5fe2e3e69094ff22d9fbca78446d4eb31"
      depends_on "node"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.10/arcsync-mcp-0.3.10-linux-arm64.tar.gz"
      sha256 "2c6f03abd2d2c82b26967deccb46c23112b28941782932a8bec621591fbac5f3"
    end
    on_intel do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.10/arcsync-mcp-0.3.10-linux-x64.tar.gz"
      sha256 "1c30035fb3f38ae426aecbc30905835a5407f8917e994c501b9788762c478499"
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
