require 'puppet/util/plist' if Puppet.features.cfpropertylist?

xcode_version_plist = '/Applications/Xcode.app/Contents/version.plist'

Facter.add(:xcode_build_version) do
  confine kernel: 'Darwin'
  setcode do
    version = nil
    if File.exist?(xcode_version_plist)
      plist = Puppet::Util::Plist.read_plist_file(xcode_version_plist)
      if plist.include? 'ProductBuildVersion'
        version = plist['ProductBuildVersion']
      end
    end
    version
  end
end
