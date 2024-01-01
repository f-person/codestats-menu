//
//  DataFetcher.swift
//  codestats-menu
//
//  Created by arshak ‎ on 01.01.24.
//

import Combine
import Foundation
import SwiftUI

public class AccountDataFetcher: ObservableObject {
    public static let shared = AccountDataFetcher()
    
    @Published public var xp: Int = 0
    @Published public var currentError: String?

    private var timer: Timer? = nil
    private let preferences = AppPreferences.shared
    private var cancellables: Set<AnyCancellable> = []

    private init() {
        setupFetchingOnPreferenceChange(publisher: preferences.$username)
        setupFetchingOnPreferenceChange(publisher: preferences.$fetchInterval)
    }

    private func setupFetchingOnPreferenceChange<T>(publisher: Published<T>.Publisher) {
        publisher
            .sink { [weak self] _ in DispatchQueue.main.async { self?.startFetching() } }
            .store(in: &cancellables)
    }

    public func startFetching() {
        stopFetching()

        let username = preferences.username
        print("the username is \(username ?? "")")
        if username == nil || username!.isEmpty {
            return currentError = "ERR: Empty username :("
        }
        let fetchInterval = preferences.fetchInterval
        print("fetch is \(fetchInterval)")

        timer = Timer.scheduledTimer(withTimeInterval: fetchInterval, repeats: true) { _ in
            self.fetchData(username: username!)
        }
    }

    public func stopFetching() {
        timer?.invalidate()
        timer = nil
    }

    private func fetchData(username: String) {
        // TODO: Add auth support for private profiles
        let url = URL(string: "https://codestats.net/api/users/\(username)")!
        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, _, _ in
            if let data = data {
                if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let newXp = json["new_xp"] as? Int
                {
                    DispatchQueue.main.async { self.xp = newXp }
                }
            }
        }.resume()
    }
}
