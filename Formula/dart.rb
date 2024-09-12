# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.6.0-232.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-232.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "d40f2125ce7a3224cc6d9a0b07231ae162e0d2edbaf61894a677895be6fdc6ad"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-232.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "9671bf815adf8a21b9fa9e7b81906ae8274d0c345c96e606eb87190ea38c8350"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-232.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "9184387c38d835b75add87432147dec7babe32675b38b9c0a6dfeebb0edf9c1d"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-232.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "18d7d5338fa627cdde653f746015234fe983a5593384b3fe29027ec52186d9a9"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-232.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "9fa0081cd512f95c2e48dc1c0388eac775b5f50e9aa40fe851deb9e36850e858"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-232.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "326924a40563c49b3d971b8248c9b4d50f3e0447255555963281a0b59918f816"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.3/sdk/dartsdk-macos-x64-release.zip"
    sha256 "7d673ca3ece0ff563061d65a0e5b84ac8905d26c257fc8dc3d543c8dafa1d0fc"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.3/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "c73ea25a5b01312bfad0e222dbd6f0677c46e2a4faa19b9c2b18f8506da03f8b"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.3/sdk/dartsdk-linux-x64-release.zip"
      sha256 "34f6eb82b226dbeaf61ea12a6d9cdd2d3374f7baadc38a6da55545ebc6ba3500"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.3/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "5ea88c21ccc5d4388a9d304a47ac4633c40b24d54501ceb1c7b166b14497387d"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.3/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "fe82992506112aaf63aebbe2716c133db30ba2c98d97926c0947a2d8d023e5e6"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.3/sdk/dartsdk-linux-arm-release.zip"
      sha256 "30b485142f9bde8a967114a9094d499bdbb1bd3a101adadd5268ce1ac4c617db"
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
