Facter.add(:xcode_product) do
  confine osfamily: 'Darwin'
  setcode do
      if Facter.value(:xcode_tools_present) == false
          # Oh man this is bad, but we need this file to exist
          Facter::Util::Resolution.exec('/usr/bin/touch /private/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress')
          # Facter::Util::Resolution.exec('/usr/sbin/softwareupdate -l | grep "\*.*Command Line" | head -n 1 | awk -F"*" \'{print $2}\' | sed -e \'s/^ *//\' | tr -d \'\n\'')
          swupd_out = Facter::Util::Resolution.exec('/usr/sbin/softwareupdate -l')
          output = nil
          swupd_out.each_line do |line|
            if line.include? '*' and line.include? 'Command Line'
              output = line.sub! '   * ', ''
              break
            end
          end
          output.strip
      end
  end
end
