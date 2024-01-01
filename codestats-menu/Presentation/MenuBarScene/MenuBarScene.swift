//
//  MenuBarScene.swift
//  codestats-menu
//
//  Created by arshak ‎ on 01.01.24.
//

import SwiftUI

struct MenuBarScene: Scene {
    @State private var shouldDisplayPreferences = false
    @State private var preferencesWindow: NSWindow?

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

    // Opens or focuses the preferences window.
    func openPreferencesWindow() {
        if let existingWindow = preferencesWindow {
            existingWindow.makeKeyAndOrderFront(self)
            NSApp.activate()
        } else {
            let window = NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: PreferencesRootView.width, height: PreferencesRootView.height),
                styleMask: [.titled, .closable, .fullSizeContentView],
                backing: .buffered, defer: false)
            window.center()
            window.setFrameAutosaveName("Preferences")
            window.isReleasedWhenClosed = false
            window.contentView = NSHostingView(rootView: PreferencesRootView())
            window.makeKeyAndOrderFront(self)
            NSApp.activate()

            preferencesWindow = window
        }
    }
}
