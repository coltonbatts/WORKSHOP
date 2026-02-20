// SCAVENGED FROM: sindresorhus/KeyboardShortcuts
// PURPOSE: Global hotkey registration for ColorWizard's "Color Picker" shortcut
// LICENSE: MIT
//
// USAGE IN COLORWIZARD:
//   1. Add KeyboardShortcuts as SPM dependency
//   2. Define your shortcut name (see below)
//   3. Register the handler in AppDelegate or SwiftUI .task{}
//   4. Add Recorder to your Settings view

import SwiftUI
import KeyboardShortcuts

// ─── STEP 1: Define the shortcut name ───────────────────────────────
// Place this in a shared file (e.g. ShortcutNames.swift)

extension KeyboardShortcuts.Name {
    // Default: Cmd+Shift+C — user can override in settings
    static let toggleColorPicker = Self(
        "toggleColorPicker",
        default: .init(.c, modifiers: [.command, .shift])
    )
}

// ─── STEP 2: Register the global hotkey handler ─────────────────────
// Option A: In AppDelegate (traditional)

/*
@main
final class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        KeyboardShortcuts.onKeyDown(for: .toggleColorPicker) {
            ColorPickerManager.shared.toggle()
        }
    }
}
*/

// Option B: In SwiftUI (modern, auto-cleanup on view disappear)

/*
struct ColorWizardApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    for await event in KeyboardShortcuts.events(for: .toggleColorPicker) {
                        if event == .keyUp {
                            ColorPickerManager.shared.toggle()
                        }
                    }
                }
        }
    }
}
*/

// Option C: SwiftUI view modifier (cleanest)

/*
struct ContentView: View {
    @State private var pickerActive = false

    var body: some View {
        MainView()
            .onGlobalKeyboardShortcut(.toggleColorPicker, type: .keyUp) {
                pickerActive.toggle()
            }
    }
}
*/

// ─── STEP 3: Settings UI — let users record their own shortcut ──────

struct ShortcutSettingsView: View {
    var body: some View {
        Form {
            KeyboardShortcuts.Recorder(
                "Color Picker Hotkey:",
                name: .toggleColorPicker
            )
        }
        .padding()
    }
}

// ─── STEP 4: Show shortcut in menu bar ──────────────────────────────

/*
struct MenuBarView: View {
    var body: some View {
        MenuBarExtra("ColorWizard", systemImage: "eyedropper") {
            Button("Toggle Color Picker") {
                ColorPickerManager.shared.toggle()
            }
            .globalKeyboardShortcut(.toggleColorPicker)  // Shows shortcut inline
        }
    }
}
*/

#Preview {
    ShortcutSettingsView()
}
