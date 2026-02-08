import KeyboardShortcuts

extension KeyboardShortcuts.Name {
    static let buildAndRun = Self("buildAndRun", default: .init(.r, modifiers: [.control, .command]))
    static let cleanDerivedData = Self("cleanDerivedData", default: .init(.k, modifiers: [.control, .command, .shift]))
}
