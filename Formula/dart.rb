# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.6.0-114.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-114.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "7767354beacf207609675121e5ac411f1b8b894b730d8502cfde38a02eb8bd1c"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-114.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "2566c4735449f895476b4947167339699c38af9f56db195a7b0dc95f1857efad"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-114.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "c306b1f2fc1b1281d9ebd4e6d4391c6c95dbe4fd3b073e5fd0fbaa2bd19c6ded"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-114.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "a5e33d478ba57eab93926f8a59144ce9a921a520c0f476e9bdcebe1c1e64be31"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-114.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "dd71d5e487d1d109ade3984de5665e2ded00f86a488d2fc93dcf69f4bf7837e9"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-114.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "2a617efe4c2f82b5ffac7e676ac3ec466b2bf3cc49e38cce7550d2f575f2340c"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "68e6746c44eb4bf359e5b57f140b555f3c022536c58d3951ccf5fe8dc4011c32"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.0/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "730978a02a6d72b8a2e05ff7a6ef3dc34aa214ed7a1e79e06913ea7bf7227d94"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.0/sdk/dartsdk-linux-x64-release.zip"
      sha256 "011a1dd6ff4e0bb4a168f7b4e13063514fbc255dc52d1ad660bf5a28773e9773"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.0/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "13804762f99d2d80659a9850f8dbbcbfa6478ed5f27c59c0d12c96208faa9db3"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "ee2cbcc36a190a883254ddc28ef772c15735022bfc5cfc11a56dbaebd5353903"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "dec85f8439ae55f30cc29ad80b6486acd20c97b25dcaa1b3d05caab36c980323"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"]
  end

  def caveats
    <<~EOS
      Please note the path to the Dart SDK:
        #{opt_libexec}
    EOS
  end

  test do
    (testpath/"sample.dart").write <<~EOS
      void main() {
        print(r"test message");
      }
    EOS

    assert_equal "test message\n", shell_output("#{bin}/dart sample.dart")
  end
end
