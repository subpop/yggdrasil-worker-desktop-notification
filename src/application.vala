/* application.vala
 *
 * Copyright 2023 Link Dupont <link@sub-pop.net>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 *
 * SPDX-License-Identifier: AGPL-3.0-or-later
 */

internal class Message : Object {
    internal string title { get; set; }
    internal string? body { get; set; }
}

[DBus (name = "com.redhat.Yggdrasil1.Worker1")]
internal class Application : GLib.Application {
    private uint object_id;
    private HashTable<string, string> _features = new HashTable<string, string> (str_hash, str_equal);

    [DBus (name = "RemoteContent")]
    public bool remote_content { get { return false; } }

    [DBus (name = "Features")]
    public HashTable<string, string> features {
        get {
            return this._features;
        }
    }

    public Application () {
        Object (application_id: "com.redhat.Yggdrasil1.Worker1.desktop_notification");
    }

    construct {
        this._features.insert ("version", VERSION);
    }

    public override void activate () {
        this.hold ();
    }

    public override bool dbus_register (DBusConnection connection, string object_path) throws Error {
        base.dbus_register (connection, object_path);
        this.object_id = connection.register_object (object_path, this);
        return true;
    }

    public override void dbus_unregister (DBusConnection connection, string object_path) {
        base.dbus_unregister (connection, object_path);
    }

    [DBus (name = "Dispatch")]
    public void dispatch (string addr, string id, string response_to, HashTable<string, string> metadata, char[] data) throws Error {
        debug ((string) data);
        var message = Json.gobject_from_data (typeof(Message), (string) data) as Message;
        Notification notification = new Notification (message.title);
        if (message.body != null) {
            notification.set_body (message.body);
        }
        Icon icon = new ThemedIcon ("dialog-information-symbolic");
        notification.set_icon (icon);
        this.send_notification (id, notification);
    }
}
