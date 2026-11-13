import Foundation

/// Single entry point for the one privileged operation MacSense performs:
/// `do shell script … with administrator privileges`, which pops the
/// standard macOS admin sheet.
///
/// Deliberately the only copy. Three identical implementations used to
/// live in `AppState`, `UninstallRemover` and `LoginItemScanner`, so a
/// change to escaping or error handling had to be made three times —
/// in the one place where getting escaping wrong runs arbitrary
/// commands as root.
///
/// `NSAppleScript` must be driven from the main thread, hence the hop.
enum PrivilegedShell {

    /// Runs `command` as root. Returns false if the user cancelled
    /// (AppleScript error -128) or the command failed.
    static func run(_ command: String, logLabel: String) async -> Bool {
        let escaped = command
            .replacingOccurrences(of: "\\", with: "\\\\")
            .replacingOccurrences(of: "\"", with: "\\\"")
        let source = "do shell script \"\(escaped)\" with administrator privileges"

        return await withCheckedContinuation { continuation in
            DispatchQueue.main.async {
                var errorInfo: NSDictionary?
                _ = NSAppleScript(source: source)?.executeAndReturnError(&errorInfo)
                guard let errorInfo else {
                    continuation.resume(returning: true)
                    return
                }
                let code = (errorInfo[NSAppleScript.errorNumber] as? Int) ?? 0
                if code != userCancelledErrorNumber {
                    let msg = (errorInfo[NSAppleScript.errorMessage] as? String) ?? "\(errorInfo)"
                    Logger.shared.log("\(logLabel) failed (\(code)): \(msg)", level: .warning)
                }
                continuation.resume(returning: false)
            }
        }
    }

    /// Wraps a path for safe interpolation into a shell command.
    static func singleQuoted(_ s: String) -> String {
        "'" + s.replacingOccurrences(of: "'", with: "'\\''") + "'"
    }

    private static let userCancelledErrorNumber = -128
}
