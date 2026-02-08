import UserNotifications
import AppKit

private let permissionErrorCategory = "PERMISSION_ERROR"

final class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationDelegate()

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        if response.notification.request.content.categoryIdentifier == permissionErrorCategory {
            openAutomationSettings()
        }
        completionHandler()
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .sound])
    }
}

func openAutomationSettings() {
    if let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_Automation") {
        NSWorkspace.shared.open(url)
    }
}

enum NotificationManager {
    static func requestPermission() {
        let center = UNUserNotificationCenter.current()
        center.delegate = NotificationDelegate.shared
        center.requestAuthorization(options: [.alert, .sound]) { _, _ in }

        let category = UNNotificationCategory(
            identifier: permissionErrorCategory,
            actions: [],
            intentIdentifiers: []
        )
        center.setNotificationCategories([category])
    }

    static func send(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: nil
        )

        UNUserNotificationCenter.current().add(request)
    }

    static func sendPermissionError() {
        let content = UNMutableNotificationContent()
        content.title = "Automation Permission Required"
        content.body = "XcodeHelper needs permission to control Xcode. Click to open Settings."
        content.sound = .default
        content.categoryIdentifier = permissionErrorCategory

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: nil
        )

        UNUserNotificationCenter.current().add(request)
    }
}
