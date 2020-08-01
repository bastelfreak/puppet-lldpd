# lldpd
#
# @summary A module to manage lldpd and related facts
#
# @example Basic usage
#   include lldpd
#
# @param manage_facts Enable or disable the fact deployment. Doesn't work on FreeBSD yet
# @param manage_service Enable or disable the service management
# @param manage_repo Enable or disable the repository setup
# @param manage_jq Enable or disable the installation of jq (this manages only the package, not any repository that you might need)
# @param repourl String that completes the url for the upstream repository
# @param gpgkeyfingerprint String with the ID from the gpg key that signed the packages
# @param ensure Install or deinstall all related components
class lldpd (
  Boolean $manage_repo,
  Boolean $manage_jq,
  Boolean $manage_facts = true,
  Boolean $manage_service = true,
  Optional[String[1]] $repourl = undef,
  String[1] $gpgkeyfingerprint = 'EF795E4D26E48F1D7661267B431C37A97C3E114B',
  Enum['present', 'absent', 'latest'] $ensure = 'present',
) {

  contain lldpd::repo
  contain lldpd::install
  contain lldpd::service

  Class['lldpd::repo']
  -> Class['lldpd::install']
  ~> Class['lldpd::service']
}
