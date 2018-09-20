class xcode_tools::install {
  if $facts['xcode_tools_present'] == false {

    file {'/private/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress':
      ensure => 'present'
    } ->

    exec {'/usr/bin/xcode-select -r': } ->

    exec { "/usr/sbin/softwareupdate -i \"${xcode_product}\" --verbose":
      logoutput => true,
      timeout   => 0,
    } ->

    exec {'/bin/rm -f private/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress': }

  }

  if $facts['xcode_license_accepted'] == false and  $facts['xcode_command_line_tools'] == false {
    exec { '/usr/bin/xcodebuild -license accept': }
  }

  if versioncmp($facts['os']['macosx']['version']['major'], '10.14') <= 0 and $facts['xcode_sdk_headers_pkg_path']{
    apple_package{'macOS_SDK_headers':
      source => $facts['xcode_sdk_headers_pkg_path'],
      verssion => '10.0.0.0.1.1535735448',
      receipt => "com.apple.pkg.macOS_SDK_headers_for_macOS_${facts['os']['macosx']['version']['major'}"
    }
  }

}
