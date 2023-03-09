# yggdrasil-worker-desktop-notification

A worker for [yggdrasil](https://github.com/RedHatInsights/yggdrasil) that
presents data sent to it as a desktop notification. The worker uses
`GNotification` to generate and show the notification, but ultimately, the
desktop shell is responsible for presenting the notification itself.

# Installation

The easiest way to compile and install `yggdrasil-worker-desktop-notification`
is using `meson`. Because it runs as a bus-activatable D-Bus service, files must
be installed in specific directories.

Generally, it is recommended to follow your distribution's packaging guidelines
for installing projects using `meson`. What follows is a generally acceptable
set of steps to setup, compile and install using `meson`.

```
# Set up the project according to distribution-specific directory locations
meson setup --prefix /usr/local --sysconfdir /etc --localstatedir /var builddir
# Compile
meson compile -C builddir
# Install
meson install -C builddir
```

`meson` includes an optional `--destdir` to its `install` subcommand to aid in
packaging.

# Usage

The worker will register itself as able to handle messages sent to the name
"desktop_notification". It expects to receive messages with the following JSON
schema:

```json
{
    "type": "object",
    "properties": {
        "title": { "type": "string" },
        "body": { "type": "string" },
    },
    "required": ["title" ]
}
```

