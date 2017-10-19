Facter.add(:xcode_tools_present) do
  confine kernel: 'Darwin'
  setcode do
    _ = Facter::Util::Resolution.exec('/usr/sbin/pkgutil --pkgs=com.apple.pkg.CLTools_Executables')
    if $CHILD_STATUS.exitstatus.zero?
      receipt_present = true
    else
      receipt_present = false
    end
    if Facter.value(:xcode_active_directory).nil?
      false
    elsif receipt_present == false
      false
    else
      true
    end
  end
end
