//
//  PreferencesRootView.swift
//  codestats-menu
//
//  Created by arshak ‎ on 30.12.23.
//

import Foundation
import SwiftUI

/**
 Preferences view for the user settings.
 */
import Foundation
import SwiftUI

struct PreferencesRootView: View {
    static let width: Double = 300
    static let height: Double = 200

    var body: some View {
        TabView {
            PreferencesView()
                .tabItem {
                    Label("General", systemImage: "gearshape")
                }

            AboutView()
                .tabItem {
                    Label("About", systemImage: "info.circle")
                }
        }

        .frame(width: PreferencesRootView.width, height: PreferencesRootView.height)
        .padding()
        Text("🛸").padding(.bottom)
    }
}

#Preview { PreferencesRootView() }
