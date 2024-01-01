//
//  PreferencesView.swift
//  codestats-menu
//
//  Created by arshak ‎ on 30.12.23.
//

import Foundation
import SwiftUI

// TODO: Start on startup
struct PreferencesView: View {
    private let intervals: [Int] = [1, 2, 3, 5, 10, 15, 30, 60]
    @State private var fetchInterval: TimeInterval = AppPreferences.shared.fetchInterval
    @State private var launchAtLogin: Bool = AppPreferences.shared.launchAtLogin
    @State private var username: String = AppPreferences.shared.username ?? ""
    @State private var usernameDebounceTimer: DispatchWorkItem?

    var body: some View {
        Form {
            TextField("Username", text: $username)
                .padding(.horizontal)
                .padding(.bottom)
                .onChange(of: username) { _, newValue in
                    usernameDebounceTimer?.cancel()
                    let timer = DispatchWorkItem {
                        AppPreferences.shared.username = newValue
                    }
                    usernameDebounceTimer = timer
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: timer)
                }

            Picker("Fetch Interval", selection: $fetchInterval) {
                ForEach(intervals, id: \.self) { interval in
                    Text("\(interval) second\(interval == 1 ? "" : "s")").tag(TimeInterval(interval))
                }
            }
            .pickerStyle(.menu)
            .padding(.horizontal)
            .padding(.bottom)
            .onChange(of: fetchInterval) { _, newValue in
                AppPreferences.shared.fetchInterval = newValue
            }

            Toggle(isOn: $launchAtLogin, label: {
                Text("Launch at login")
            })
            .toggleStyle(.switch)
            .onChange(of: launchAtLogin) { _, newValue in
                AppPreferences.shared.launchAtLogin = newValue
            }
        }
    }
}

#Preview { PreferencesView() }
