# xcode_app_present.rb
Facter.add(:xcode_app_present) do
  confine kernel: 'Darwin'
  setcode do
    if File.exist?('/Applications/Xcode.app')
      true
    else
      false
    end
  end
end
