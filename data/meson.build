dbus = dependency('dbus-1')

desktop_file = configure_file(
  configuration: config_data,
  input: 'com.redhat.Yggdrasil1.Worker1.desktop_notification.desktop.in',
  output: '@BASENAME@',
  install_dir: get_option('datadir') / 'applications'
)

desktop_utils = find_program('desktop-file-validate', required: false)
if desktop_utils.found()
  test('Validate desktop file', desktop_utils, args: [desktop_file])
endif

configure_file(
  configuration: config_data,
  input: 'com.redhat.Yggdrasil1.Worker1.desktop_notification.service.in',
  output: '@BASENAME@',
  install_dir: dbus.get_variable('session_bus_services_dir')
)