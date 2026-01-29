//  Scope Lab #1: Scope Demo
//
//  # Instructions:
//  - With a partner, throughly annotate this file to describe
//    the scope of each and every variable and constant,
//    including those declared as part of function parameters.
//  - Add comments at the end of each line with a new variable
//    to annotate their scope.
//  - We will do the first few together.


import Foundation

let appName: String = "Scope Explorer"
var globalUserCount: Int = 0

@MainActor // Ignore this
class ScopeDemoViewModel {

    static let maxCachedItems: Int = 100
    static var sharedInstanceCount: Int = 0

    let id: UUID
    var title: String
    private var isDirty: Bool = false
    fileprivate var lastSyncDate: Date
    internal var retryCount: Int = 0
    public var isEnabled: Bool = true

    var isSynced: Bool {
        return !isDirty
    }

    private var shouldRetry: Bool {
        return retryCount < 3 && !isSynced
    }

    static var descriptionText: String {
        return "This type demonstrates many different scopes."
    }

    struct SyncSettings {
        let maxAttempts: Int
        var delayBetweenAttempts: TimeInterval
        private(set) var lastUsedVersion: String

        mutating func markUsed(version: String) {
            lastUsedVersion = version
        }
    }

    var syncSettings: SyncSettings

    init(title: String) {
        self.id = UUID()
        self.title = title
        self.syncSettings = SyncSettings(
            maxAttempts: 3,
            delayBetweenAttempts: 2.0,
            lastUsedVersion: "1.0"
        )
        self.lastSyncDate = Date()

        let initialStatusMessage = "Created view model with title: \(title)"
        print(initialStatusMessage)

        ScopeDemoViewModel.sharedInstanceCount += 1
    }

    convenience init() {
        self.init(title: "Untitled")
    }

    func performSync() {
        let startTime = Date()
        var attempts = 0

        let retryCount = 0
        print("Local retryCount (shadowing property): \(retryCount)")

        func attemptSyncOnce() -> Bool {
            attempts += 1
            globalUserCount += 1

            let syncId = UUID()
            print("Attempt \(attempts) with id \(syncId)")
            return Bool.random()
        }

        while attempts < syncSettings.maxAttempts {
            let success = attemptSyncOnce()
            if success {
                lastSyncDate = Date()
                isDirty = false
                break
            }
        }

        let elapsed = Date().timeIntervalSince(startTime)
        print("Sync finished in \(elapsed) seconds")
    }

    private func logStatusChange(from old: String, to new: String) {
        let logMessage = "Status changed from \(old) to \(new)"
        print(logMessage)
    }

    func updateTitle(to newTitle: String, animated: Bool) {
        let oldTitle = title
        title = newTitle
        isDirty = true

        if animated {
            animateTitleChange(from: oldTitle, to: newTitle)
        }
    }

    private func animateTitleChange(from old: String, to new: String) {
        let animationDuration: TimeInterval = 0.25

        let animations = {
            let transitionText = "\(old) → \(new)"
            print("Animating title change: \(transitionText)")
        }

        performAnimation(duration: animationDuration, animations: animations)
    }

    private func performAnimation(duration: TimeInterval, animations: () -> Void) {
        print("Starting animation for \(duration) seconds")
        animations()
        print("Animation complete")
    }

    static func resetSharedInstanceCount() {
        sharedInstanceCount = 0
    }

    static func makeSampleViewModels() -> [ScopeDemoViewModel] {
        let titles = ["Home", "Profile", "Settings", "About"]
        var result: [ScopeDemoViewModel] = []

        for name in titles {
            let model = ScopeDemoViewModel(title: name)
            result.append(model)
        }

        return result
    }
    
    fileprivate func markAsDirtyForTesting() {
        isDirty = true
    }
}

fileprivate extension ScopeDemoViewModel {
    func debugPrintState() {
        print("Debug id: \(id)")
        print("Debug lastSyncDate: \(String(describing: lastSyncDate))")
    }
}

@MainActor // Ignore this
func runScopeDemo() {
    let models = ScopeDemoViewModel.makeSampleViewModels()
    print("Created \(models.count) models in \(appName)")
    print("Global user count: \(globalUserCount)")

    if let first = models.first {
        first.performSync()
    }
}
