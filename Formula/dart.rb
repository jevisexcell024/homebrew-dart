# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.5.0-164.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-164.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "33596c458676c35ade44ca2e353b84748dcab015752209b522f6ef60663cb7a3"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-164.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "5b85b2f62c7e70b1f40cd241b5f251a85ec5f33772eb03be13e2c2f0f844ed5c"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-164.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "5f7e653396c50d33badb2d9ed278fd3cb6c38d561845a5d60e6ddf3caa6d95f4"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-164.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "8f16dc2c5c9148295e9b7d5b329078212f09e0fa914f25f395c4166c60336100"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-164.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "a20c2bf3fe579b5277696613d2ddf9a69c443f67112559fd506967c7be1eb153"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-164.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "16298e3fb263ab750642be43235775f3a8f11b71f76e7f2866446e9f0e1b2ce3"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "c6748621035b13994c3e77073a2cf9d9eb007e8d0b93a1f6329b7870cb5e2798"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.1/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "02ac6e6269da03f9d99d01376c3186d95876e72da98d265bb8d541a31db9a575"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.1/sdk/dartsdk-linux-x64-release.zip"
      sha256 "d1078d3dc8d69b58b0e9b84e639288206631ae7bf88b13629788e8962029d142"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.1/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "1be254b42d3ad123219e7bdf84d819ae43e863286bb55b4f48cea4d630319bb4"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "84bc75b0ec3eb5b18690bde364a5a144ccf110f4599c4a2a7d2747d08d9383a8"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "e04cfe81672dcc126640669f6fc881ba154028e3f2ee22b57b13d0cb54007b9e"
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
