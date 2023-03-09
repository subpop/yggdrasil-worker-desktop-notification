project('yggdrasil-worker-desktop-notification', ['c', 'vala'],
          version: '0.1.0',
    meson_version: '>= 0.59.0',
  default_options: [ 'warning_level=2', 'werror=false', ],
)

config_data = configuration_data({
  'bindir': get_option('prefix') / get_option('bindir'),
  'version': meson.project_version()
})

subdir('data')
subdir('src')
