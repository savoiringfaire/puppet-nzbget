# == Class nzbget::params
#
# This class is meant to be called from nzbget.
# It sets service params according to user preferences.
#
class nzbget::params {
  $packages = [
    'unrar',
    'par2',
    'parchive',
  ]

  $masks = [$::nzbget::manage_service_dirs[1], $::nzbget::manage_data_dirs[1]]

  $::nzbget::config_file_dir = undef
  $daemon_required_mounts = delete(unique([
    $::nzbget::service_dir,
    $::nzbget::main_dir,
    $::nzbget::config_file_dir,
    $::nzbget::nzb_dir,
    $::nzbget::queue_dir,
    $::nzbget::temp_dir,
    $::nzbget::cert_dir,
    $::nzbget::secure_cert_dir,
    $::nzbget::secure_key_dir,
    $::nzbget::web_dir] +
    $::nzbget::required_dir), '')

  $required_dir_config_mounts = delete(unique([
    $::nzbget::service_dir,
    $::nzbget::main_dir,
    $::nzbget::intermediate_dir,
    $::nzbget::destination_dir,
    $::nzbget::nzb_dir,
    $::nzbget::queue_dir,
    $::nzbget::temp_dir,
    $::nzbget::lock_dir,
    $::nzbget::log_dir,
    $::nzbget::cert_dir,
    $::nzbget::secure_cert_dir,
    $::nzbget::secure_key_dir,
    $::nzbget::unpack_pass_dir,
    $::nzbget::web_dir] +
    $::nzbget::required_dir +
    $::nzbget::script_dir), '')

  $managed_service_dirs = nzb_dir_filter(
    [$::nzbget::service_dir, $main_dir] + $script_dir,
    $masks)

  $_managed_data_dirs = nzb_dir_filter(
    [$::nzbget::intermediate_dir,
      $::nzbget::destination_dir,
      $::nzbget::nzb_dir,
      $::nzbget::queue_dir,
      $::nzbget::temp_dir],
    $masks)

  # If both are managed, remove any service dupes from data dirs.
  if ($::nzbget::manage_service_dirs[0] and $::nzbget::manage_data_dirs[0]) {
    $managed_data_dirs = delete($_managed_data_dirs, $managed_service_dirs)
  } else {
    $managed_data_dirs = $_managed_data_dirs
  }

  case $::nzbget::group {
    $::nzbget::user: { $user_resource_group = undef }
    default:         { $user_resource_group = $::nzbget::group }
  }
}
