import AppKit

enum XcodeActions {
    /// AppleScript error code for "not permitted" (user denied Automation permission)
    private static let errAEEventNotPermitted = -1743

    static func buildAndRun() {
        let isRunning = NSWorkspace.shared.runningApplications.contains {
            $0.bundleIdentifier == "com.apple.dt.Xcode"
        }

        guard isRunning else {
            NotificationManager.send(
                title: "XcodeHelper",
                body: "Xcode is not running."
            )
            return
        }

        let script = """
        tell application "Xcode"
            activate
            run workspace document 1
        end tell
        """

        var error: NSDictionary?
        NSAppleScript(source: script)?.executeAndReturnError(&error)

        if let error = error {
            let errorNumber = error[NSAppleScript.errorNumber] as? Int ?? 0
            if errorNumber == errAEEventNotPermitted {
                NotificationManager.sendPermissionError()
            } else {
                let message = error[NSAppleScript.errorMessage] as? String ?? "Unknown error"
                NotificationManager.send(
                    title: "XcodeHelper",
                    body: "Build & Run failed: \(message)"
                )
            }
        }
    }
}
