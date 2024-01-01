//
//  TotalXPLabel.swift
//  codestats-menu
//
//  Created by arshak ‎ on 01.01.24.
//

import SwiftUI

/**
 Handles displaying the new total XP.
 */
struct TotalXPLabel: View {
    @ObservedObject var dataFetcher = AccountDataFetcher.shared

    var body: some View {
        if dataFetcher.currentError != nil {
            Text(dataFetcher.currentError!)
        } else {
            Text("\(dataFetcher.xp) XP")
                .onAppear {
                    dataFetcher.startFetching()
                }
        }
    }
}
