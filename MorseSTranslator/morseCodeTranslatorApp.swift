//
//  MorseCodeTranslatorApp.swift
//  MorseCodeTranslator
//
//  Created by 50. on 2025/2/26.
//

import SwiftUI

@main
struct morseCodeTranslatorApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(MorseCodeViewModel())
                .environmentObject(ThemeManager())
                .preferredColorScheme(.dark)
        }
    }
}
