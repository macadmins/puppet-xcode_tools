require 'puppet/util/plist'

Facter.add(:xcode_license_accepted) do
  confine kernel: 'Darwin'
  setcode do
    xcode_active_directory = Facter.value(:xcode_active_directory)
    if xcode_active_directory.nil?
      # no tools installed
      nil
    elsif xcode_active_directory == '/Library/Developer/CommandLineTools'
      # we are using the CLI tools which don't need license accepted
      true
    elsif xcode_active_directory.include? '.app'
      # we need to check license
      license_plist = '/Library/Preferences/com.apple.dt.Xcode.plist'

      result = false unless File.exist? license_plist

      license_plist_data = Puppet::Util::Plist.read_plist_file(license_plist)

      xcode_license_info_plist = xcode_active_directory.chomp('Developer') + 'Resources/LicenseInfo.plist'
      xcode_license_info_plist_data = Puppet::Util::Plist.read_plist_file(xcode_license_info_plist)

      xcode_info_plist = xcode_active_directory.chomp('Developer') + 'Info.plist'
      xcode_info = Puppet::Util::Plist.read_plist_file(xcode_info_plist)
      xcode_version = xcode_info['CFBundleShortVersionString']

      license_type = xcode_license_info_plist_data['licenseType']
      license_id = xcode_license_info_plist_data['licenseID']

      if license_plist_data['IDEXcodeVersionForAgreedTo' + license_type + 'License'] != xcode_version
        result = false
      elsif license_plist_data['IDELast' + license_type + 'LicenseAgreedTo'] != license_id
        result = false
      else
        result = true
      end

      result

    end
  end
end
