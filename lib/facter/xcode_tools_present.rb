Facter.add(:xcode_tools_present) do
  confine kernel: 'Darwin'
  setcode do
    if Facter.value(:xcode_active_directory).nil?
      false
    else
      true
    end
  end
end
