//
//  AppPreferences.swift
//  codestats-menu
//
//  Created by arshak ‎ on 01.01.24.
//

import Foundation

class AppPreferences: ObservableObject {
    public static let shared = AppPreferences()
    
    private let defaults = UserDefaults.standard
    private let usernameKey = "username"
    private let fetchIntervalKey = "fetchInterval"
    
    private init() {
        username = defaults.string(forKey: usernameKey)
        fetchInterval = defaults.double(forKey: fetchIntervalKey)
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
}
