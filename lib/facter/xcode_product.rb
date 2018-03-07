Facter.add(:xcode_product) do
  confine osfamily: 'Darwin'
  setcode do
    if Facter.value(:xcode_tools_present) == false
      # Oh man this is bad, but we need this file to exist
      Facter::Util::Resolution.exec('/usr/bin/touch /private/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress')
      swupd_out = Facter::Util::Resolution.exec('/usr/sbin/softwareupdate -l')
      output = nil
      swupd_out.each_line do |line|
        if line.include?('*') && line.include?('Command Line')
          output = line.sub! '   * ', ''
          break
        end
      end
      temp_file = '/private/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress'
      File.delete(temp_file) if File.exist?(temp_file)
      output.strip
    end
  end
end
