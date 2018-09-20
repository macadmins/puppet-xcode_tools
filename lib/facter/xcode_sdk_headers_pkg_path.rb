# xcode_sdk_headers_pkg_path.rb
Facter.add(:xcode_sdk_headers_pkg_path) do
  confine kernel: 'Darwin'
  setcode do
    out = nil
    if File.exist?('/Library/Developer/CommandLineTools/Packages')
      Dir.glob('/Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_*.pkg') do | pkg |
        out = pkg
        break
      end
    end
    out
  end
end
