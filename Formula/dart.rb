# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.4.0-247.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-247.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "62f15762641a5aac4f61d6719a159d62188646c1e43c8bd93fd33eafe63229f6"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-247.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "95eec1e3dfa7c891d928c0ae3be9550675eefa95b240ea5dd414f9b4c2a90369"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-247.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "3cff0b896fb2f665c8ab2cbf746882fcf42d2def7c3c64db7e2208ee092932da"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-247.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "b4b23033833038bff40f31b1e5a1dbfeb8918d24694741418236496af5a3864d"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-247.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "98c0c8bd016ba6e1156d4630409f47ef42e16226efe331751e706711496208fc"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-247.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "e20bf084678b51e65d22fee57053e8649e95f27565551f1ddb15cf661c7bf170"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "537146873435b3f0d2a39cea421c958433526cedd3ab81afed7317e91c492446"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.2/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "c7d79bfff7f8c929b50e5160af1cc4d5a0ea70f77765027086679cceebe2d839"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "2025a47313408d1b1be943b0ce4ca3d5b629f2a4b2a6cd8ea8c6a323f1693d1e"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "16baf24de9e47858152b8a07e2d286ad5298b0d4902c9a8f23318accba8f92cb"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "a26b4f98e7b7fb6feb8abe4864ab5c890434b0a048220e27f1886b7435c1321d"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "6a394b1206a73001193befa7aecbfb6bc8c8d154ed4d3018ea9fc9c4c321ea4d"
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
