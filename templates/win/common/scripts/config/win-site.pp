include windows_template::policies::local_group_policies
include windows_template::policies::security_policies
include windows_template::firewall::firewall
include windows_template::services::configure_services
include windows_template::registry::machine
include windows_template::registry::user
include windows_template::apps::sysinternals
include windows_template::bootcfg::bootcfg

# Install Apps as required.
include windows_template::apps::gitforwin

if ($psversionmajor >= '4') {
  # Powershell 7 requires WMF 4.0 or greater for PS7
  include windows_template::apps::powershell7
}
# Conditional for Core checkining
# only allowed for main installs and non-core
if (lookup('packer.windows.installationtype') != 'Server Core') and ($::operatingsystemrelease != '2008')
{
  include windows_template::apps::chrome
  include windows_template::apps::notepadplusplus
}

# Select an SSH layer
case lookup('packer.ssh_platform') {
  'wsl_ssh':      { include windows_template::ssh::wsl_ssh }
  'cygwin-2.4.0': { include windows_template::ssh::cygwin_240 }
  default: {} # None provided
}
