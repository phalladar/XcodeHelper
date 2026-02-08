import AppKit
import KeyboardShortcuts

final class AppDelegate: NSObject, NSApplicationDelegate {
    private var statusBarController: StatusBarController?

    func applicationDidFinishLaunching(_ notification: Notification) {
        NotificationManager.requestPermission()

        // Defer status item creation until the run loop is fully established
        DispatchQueue.main.async {
            self.statusBarController = StatusBarController()

            KeyboardShortcuts.onKeyUp(for: .buildAndRun) {
                XcodeActions.buildAndRun()
            }

            KeyboardShortcuts.onKeyUp(for: .cleanDerivedData) {
                DerivedDataCleaner.clean()
            }
        }
    }
}
