//
//  AppPreferences.swift
//  codestats-menu
//
//  Created by arshak ‎ on 01.01.24.
//

import Foundation
import ServiceManagement

class AppPreferences: ObservableObject {
    public static let shared = AppPreferences()
    
    private let defaults = UserDefaults.standard
    private let usernameKey = "username"
    private let fetchIntervalKey = "fetchInterval"
    private let launchOnLoginKey = "launchOnLogin"
    
    private init() {
        username = defaults.string(forKey: usernameKey)
        fetchInterval = defaults.double(forKey: fetchIntervalKey)
        launchAtLogin = defaults.bool(forKey: launchOnLoginKey)
    }

    @Published public var username: String? {
        didSet {
            defaults.setValue(username, forKey: usernameKey)
        }
    }
    
    @Published public var fetchInterval: TimeInterval {
        didSet {
            defaults.setValue(fetchInterval, forKey: fetchIntervalKey)
        }
    }
    
    @Published public var launchAtLogin: Bool {
        didSet {
            do {
                if (launchAtLogin) {
                    try SMAppService.mainApp.register()
                } else {
                    try SMAppService.mainApp.unregister()
                }
                
                defaults.setValue(launchAtLogin, forKey: launchOnLoginKey)
            } catch {
                print("ERR: Couldn't set login settings.")
            }
        }
    }
}
