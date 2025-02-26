import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var theme: ThemeManager
    
    var body: some View {
        ZStack {
            CyberBackground()
            
            Form {
                Section(header: Text("Theme")) {
                    Picker("Select Theme", selection: $theme.activeTheme) {
                        ForEach(ThemeManager.Theme.allCases, id: \.self) { theme in
                            Text(theme.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Effects")) {
                    Toggle("Enable Neon Glow", isOn: $theme.isGlowingEnabled)
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.clear)
        }
        .navigationTitle("Settings")
    }
}