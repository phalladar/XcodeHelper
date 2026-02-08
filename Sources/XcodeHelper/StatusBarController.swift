import AppKit

final class StatusBarController {
    private var statusItem: NSStatusItem!

    init() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        if let button = statusItem.button {
            if let image = NSImage(systemSymbolName: "hammer", accessibilityDescription: "XcodeHelper") {
                image.isTemplate = true
                button.image = image
            } else {
                button.title = "XH"
            }
        }

        buildMenu()
    }

    private func buildMenu() {
        let menu = NSMenu()

        let buildItem = NSMenuItem(title: "Build & Run in Xcode", action: #selector(buildAndRun), keyEquivalent: "")
        buildItem.target = self
        menu.addItem(buildItem)

        let cleanItem = NSMenuItem(title: "Clean Derived Data", action: #selector(cleanDerivedData), keyEquivalent: "")
        cleanItem.target = self
        menu.addItem(cleanItem)

        menu.addItem(.separator())

        let fixPermsItem = NSMenuItem(title: "Fix Permissions...", action: #selector(fixPermissions), keyEquivalent: "")
        fixPermsItem.target = self
        menu.addItem(fixPermsItem)

        let prefsItem = NSMenuItem(title: "Preferences...", action: #selector(openPreferences), keyEquivalent: ",")
        prefsItem.target = self
        menu.addItem(prefsItem)

        menu.addItem(.separator())

        let quitItem = NSMenuItem(title: "Quit", action: #selector(quit), keyEquivalent: "q")
        quitItem.target = self
        menu.addItem(quitItem)

        statusItem.menu = menu
    }

    @objc private func buildAndRun() {
        XcodeActions.buildAndRun()
    }

    @objc private func cleanDerivedData() {
        DerivedDataCleaner.clean()
    }

    @objc private func fixPermissions() {
        openAutomationSettings()
    }

    @objc private func openPreferences() {
        PreferencesWindowController.shared.showWindow()
    }

    @objc private func quit() {
        NSApplication.shared.terminate(nil)
    }
}
