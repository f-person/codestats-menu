//
//  MenuBarScene.swift
//  codestats-menu
//
//  Created by arshak ‎ on 01.01.24.
//

import SwiftUI

struct MenuBarScene: Scene {
    @State private var shouldDisplayPreferences = false

    var body: some Scene {
        MenuBarExtra {
            Button("Preferences") {
                openPreferencesWindow()
            }
            .keyboardShortcut(",")
            .sheet(isPresented: $shouldDisplayPreferences) {
                PreferencesView() // Present the preferences view in a sheet
            }

            Divider()

            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }.keyboardShortcut("q")
        }
    label: {
            TotalXPLabel()
        }
    }

    // Method to open the preferences window
    func openPreferencesWindow() {
        let preferencesWindow = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: PreferencesRootView.width, height: PreferencesRootView.height),
            styleMask: [.titled, .closable, .fullSizeContentView],
            backing: .buffered, defer: false)
        preferencesWindow.center()
        preferencesWindow.setFrameAutosaveName("Preferences")
        preferencesWindow.isReleasedWhenClosed = false
        preferencesWindow.contentView = NSHostingView(rootView: PreferencesRootView())
        preferencesWindow.makeKeyAndOrderFront(nil)
    }
}
