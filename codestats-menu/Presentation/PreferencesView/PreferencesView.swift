//
//  PreferencesView.swift
//  codestats-menu
//
//  Created by arshak ‎ on 30.12.23.
//

import Foundation
import SwiftUI

struct PreferencesView: View {
    private let intervals: [Int] = [1, 2, 3, 5, 10, 15, 30, 60]
    @State private var localFetchInterval: TimeInterval = AppPreferences.shared.fetchInterval

    var body: some View {
        Form {
            TextField("Username", text: Binding(
                get: { AppPreferences.shared.username ?? "" },
                set: { AppPreferences.shared.username = $0 }
            ))
            .padding(.horizontal)
            .padding(.bottom)

            Picker("Fetch Interval", selection: $localFetchInterval) {
                   ForEach(intervals, id: \.self) { interval in
                       Text("\(interval) second\(interval == 1 ? "" : "s")").tag(TimeInterval(interval))
                   }
               }
               .pickerStyle(.menu)
               .padding(.horizontal)
               .onChange(of: localFetchInterval) { newValue in
                   AppPreferences.shared.fetchInterval = newValue
               }
        }
    }
}

#Preview { PreferencesView() }
