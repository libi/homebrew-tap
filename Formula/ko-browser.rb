class KoBrowser < Formula
  desc "A fast, token-efficient browser for AI agents"
  homepage "https://github.com/libi/ko-browser"
  url "https://github.com/libi/ko-browser/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "f0bd8ca45bf7c3d61642c03afeecce222b3dfe4469d413235c848dbcdb2848f0"
  license "MIT"
  version "0.1.2"
  head "https://github.com/libi/ko-browser.git", branch: "main"

  depends_on "go" => :build
  depends_on "pkgconf" => :build
  depends_on "tesseract"

  def install
    ENV["CGO_ENABLED"] = "1"

    ldflags = %W[
      -s -w
      -X github.com/libi/ko-browser/cmd.version=#{version}
      -X github.com/libi/ko-browser/cmd.commit=homebrew
      -X github.com/libi/ko-browser/cmd.date=homebrew
    ]

    system "go", "build", *std_go_args(output: bin/"kbr", ldflags: ldflags), "-tags=ocr", "./cmd/kbr"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kbr version")
  end
end
