class ArcsyncMcp < Formula
  desc "MCP server giving coding agents ArcSync architecture graphs"
  homepage "https://arcsync.dev/docs/mcp"
  version "0.3.9"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.9/arcsync-mcp-0.3.9-darwin-arm64.tar.gz"
      sha256 "609f602f395e57c244efa14ea586f45dd97f7c5d630f04e50ca2715d617c8c80"
    end
    on_intel do
      url "https://registry.npmjs.org/arcsync-mcp/-/arcsync-mcp-0.3.9.tgz"
      sha256 "d3e21259e1721aaa11e6d07ec362a4e64143c3edddd2f1c80ef2065b636d4d77"
      depends_on "node"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.9/arcsync-mcp-0.3.9-linux-arm64.tar.gz"
      sha256 "b0ca070393cddbd7feb73323af044d806d2d80073e7ce6e3ebb70645b3433fa7"
    end
    on_intel do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.9/arcsync-mcp-0.3.9-linux-x64.tar.gz"
      sha256 "7ff0049760ffb91b14a9566ce5ca4684721fce046d5ea160655ed380ff420ce5"
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
