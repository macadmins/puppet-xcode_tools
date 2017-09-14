require 'puppet/util/plist' if Puppet.features.cfpropertylist?

xcode_version_plist = '/Applications/Xcode.app/Contents/version.plist'

Facter.add(:xcode_version) do
  confine kernel: 'Darwin'
  setcode do
    version = '0'
    if File.exist?(crypt_info_plist)
      plist = Puppet::Util::Plist.read_plist_file(xcode_version_plist)
      if plist.include? 'CFBundleShortVersionString'
        version = plist['CFBundleShortVersionString']
      end
    end
    version
  end
end