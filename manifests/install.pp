class xcode_tools::install {
  if $::xcode_tools_present == false {

    file {'/private/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress':
      ensure => 'present'
    } ->

    exec { "/usr/sbin/softwareupdate -i \"${xcode_product}\" --verbose":
      logoutput => true,
      timeout   => 0,
    } ->

    exec {'/bin/rm -f private/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress': }
  }
}
