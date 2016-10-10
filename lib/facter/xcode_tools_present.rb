Facter.add(:xcode_tools_present) do
  confine osfamily: 'Darwin'
  setcode do
      Facter::Util::Resolution.exec('/usr/bin/xcode-select -p')
      if $CHILD_STATUS.exitstatus.nonzero?
        false
      else
        true
      end
  end
end
