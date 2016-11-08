Facter.add(:xcode_active_directory) do
  confine kernel: 'Darwin'
  setcode do
    output = Facter::Util::Resolution.exec('/usr/bin/xcode-select -p')
    if $CHILD_STATUS.exitstatus.nonzero?
      nil
    else
      if File.exist?(output.to_s.strip)
        output
      else
        nil
      end
    end
  end
end
