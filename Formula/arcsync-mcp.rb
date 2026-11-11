class ArcsyncMcp < Formula
  desc "MCP server giving coding agents ArcSync architecture graphs"
  homepage "https://arcsync.dev/docs/mcp"
  version "0.3.18"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.18/arcsync-mcp-0.3.18-darwin-arm64.tar.gz"
      sha256 "fe2318bd3d5aa613b2a95a755521e5a651ff0b0a0aa0352a01e0046a42c32057"
    end
    on_intel do
      url "https://registry.npmjs.org/arcsync-mcp/-/arcsync-mcp-0.3.18.tgz"
      sha256 "5611893de7fb9f6e40d01745928212567d48c1f8cd37509b25bb2938e9c81072"
      depends_on "node"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.18/arcsync-mcp-0.3.18-linux-arm64.tar.gz"
      sha256 "259263201801313084641ac2aa225ed6071e9a0787329e4fe484fdcd2e20441d"
    end
    on_intel do
      url "https://github.com/VanLandinghamLabs/arcsync-mcp/releases/download/v0.3.18/arcsync-mcp-0.3.18-linux-x64.tar.gz"
      sha256 "6cc67115683bdb300ea37c7d44854b1b942255516edd90427de6c0dca996065f"
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
