/*
 * Copyright 2024 Jeremy Wootten. (https://github.com/jeremypw)
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public class Clipboard.Indicator : Wingpanel.Indicator {
    private Gtk.Image panel_icon;
    private Gtk.Grid main_grid;

    public Wingpanel.IndicatorManager.ServerType server_type { get; construct set; }

    public Indicator (Wingpanel.IndicatorManager.ServerType indicator_server_type) {
        GLib.Intl.bindtextdomain (GETTEXT_PACKAGE, LOCALEDIR);
        GLib.Intl.bind_textdomain_codeset (GETTEXT_PACKAGE, "UTF-8");

        Object (code_name: "clipboard",
                server_type: indicator_server_type);
    }

    public override Gtk.Widget get_display_widget () {
        if (panel_icon == null) {
            panel_icon = new Gtk.Image.from_icon_name ("edit-copy-symbolic", Gtk.IconSize.SMALL_TOOLBAR);

            if (server_type == Wingpanel.IndicatorManager.ServerType.GREETER) {
                this.visible = false;
            } else {
                // var visible_settings = new Settings ("io.elementary.desktop.wingpanel.clipboard");
                // visible_settings.bind ("show-indicator", this, "visible", SettingsBindFlags.DEFAULT);
                this.visible = true;
            }
        }

        return panel_icon;
    }

    public override Gtk.Widget? get_widget () {
        if (main_grid == null) {
            if (server_type == Wingpanel.IndicatorManager.ServerType.GREETER) {
                main_grid = null;
            } else {
                main_grid = new HistoryWidget ();
            }
        }

        return main_grid;
    }

    public override void opened () {
    }

    public override void closed () {
    }
}

public Wingpanel.Indicator? get_indicator (Module module, Wingpanel.IndicatorManager.ServerType server_type) {
    debug ("Activating Clipboard Indicator");
    return new Clipboard.Indicator (server_type);
}
