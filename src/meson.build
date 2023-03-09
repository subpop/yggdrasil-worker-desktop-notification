sources = [
  'application.vala',
  'main.vala',
]

sources += configure_file(
  input: 'constants.vala.in',
  output: '@BASENAME@',
  configuration: config_data
)


deps = [
  dependency('gee-0.8'),
  dependency('gio-2.0'),
  dependency('glib-2.0'),
  dependency('gobject-2.0'),
  dependency('json-glib-1.0'),
]

executable('yggdrasil-worker-desktop-notification', sources,
  vala_args: '--target-glib=2.58',  dependencies: deps,
  install: true,
)
