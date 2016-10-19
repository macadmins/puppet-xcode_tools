class xcode_tools {
  if $facts['os']['family'] == 'Darwin'{
    include xcode_tools::install
  }
}
