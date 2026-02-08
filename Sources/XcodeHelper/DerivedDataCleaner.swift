import Foundation

enum DerivedDataCleaner {
    static func clean() {
        let derivedDataPath = NSHomeDirectory() + "/Library/Developer/Xcode/DerivedData"
        let fileManager = FileManager.default

        guard fileManager.fileExists(atPath: derivedDataPath) else {
            NotificationManager.send(
                title: "Clean Derived Data",
                body: "DerivedData directory does not exist."
            )
            return
        }

        do {
            let contents = try fileManager.contentsOfDirectory(atPath: derivedDataPath)
            var cleaned = 0
            var errors = 0

            for item in contents {
                let itemPath = (derivedDataPath as NSString).appendingPathComponent(item)
                do {
                    try fileManager.removeItem(atPath: itemPath)
                    cleaned += 1
                } catch {
                    errors += 1
                }
            }

            if errors > 0 {
                NotificationManager.send(
                    title: "Clean Derived Data",
                    body: "Cleaned \(cleaned) item(s). \(errors) item(s) could not be removed (may be in use)."
                )
            } else if cleaned == 0 {
                NotificationManager.send(
                    title: "Clean Derived Data",
                    body: "DerivedData was already empty."
                )
            } else {
                NotificationManager.send(
                    title: "Clean Derived Data",
                    body: "Successfully cleaned \(cleaned) item(s)."
                )
            }
        } catch {
            NotificationManager.send(
                title: "Clean Derived Data",
                body: "Failed to read DerivedData directory: \(error.localizedDescription)"
            )
        }
    }
}
