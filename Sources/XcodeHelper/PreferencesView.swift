import SwiftUI
import KeyboardShortcuts

struct PreferencesView: View {
    var body: some View {
        Form {
            Section {
                HStack {
                    Text("Build & Run:")
                    Spacer()
                    KeyboardShortcuts.Recorder(for: .buildAndRun)
                }

                HStack {
                    Text("Clean Derived Data:")
                    Spacer()
                    KeyboardShortcuts.Recorder(for: .cleanDerivedData)
                }
            } header: {
                Text("Global Keyboard Shortcuts")
                    .font(.headline)
            }

            Section {
                Button("Reset to Defaults") {
                    KeyboardShortcuts.reset(.buildAndRun, .cleanDerivedData)
                }
            }
        }
        .formStyle(.grouped)
        .frame(width: 380, height: 200)
    }
}
