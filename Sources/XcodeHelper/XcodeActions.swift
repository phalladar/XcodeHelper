import AppKit

enum XcodeActions {
    static func buildAndRun() {
        let xcodeApps = NSWorkspace.shared.runningApplications.filter {
            $0.bundleIdentifier == "com.apple.dt.Xcode"
        }

        guard !xcodeApps.isEmpty else {
            NotificationManager.send(
                title: "XcodeHelper",
                body: "Xcode is not running."
            )
            return
        }

        let script = """
        tell application "Xcode" to activate
        delay 0.3
        tell application "System Events"
            keystroke "r" using {command down}
        end tell
        """

        var error: NSDictionary?
        if let appleScript = NSAppleScript(source: script) {
            appleScript.executeAndReturnError(&error)
        }

        if let error = error {
            let message = error[NSAppleScript.errorMessage] as? String ?? "Unknown error"
            NotificationManager.send(
                title: "Build & Run Failed",
                body: message
            )
        } else {
            NotificationManager.send(
                title: "XcodeHelper",
                body: "Build & Run triggered in Xcode."
            )
        }
    }
}
