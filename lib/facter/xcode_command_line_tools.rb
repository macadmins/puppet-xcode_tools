Facter.add(:xcode_command_line_tools) do
  confine kernel: 'Darwin'
  setcode do
    if Facter.value(:xcode_active_directory).include? '.app'
      true
    else
      false
    end
  end
end
