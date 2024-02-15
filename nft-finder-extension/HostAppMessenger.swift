// ∅ nft-folder-macos 2024

import Cocoa

// TODO: refactor
struct HostAppMessenger {
    
    static func didSelectSyncMenuItem() {
        if let url = URL(string: URL.deeplinkScheme + "?sync") {
            DispatchQueue.main.async { NSWorkspace.shared.open(url) }
        }
    }
    
    static func didSelectViewOnMenuItem(path: String, gallery: WebGallery) {
        if let url = URL(string: URL.deeplinkScheme + "?view=\(path)\(gallery.rawValue)") {
            DispatchQueue.main.async { NSWorkspace.shared.open(url) }
        }
    }
    
    static func didSelectControlCenterMenuItem() {
        if let url = URL(string: URL.deeplinkScheme + "?show") {
            DispatchQueue.main.async { NSWorkspace.shared.open(url) }
        }
    }
    
    static func didBeginObservingDirectory(mbAddressName: String?) {
        // TODO: pass address folder name
        if let deeplink = URL(string: URL.deeplinkScheme + "?monitor") {
            DispatchQueue.main.async { NSWorkspace.shared.open(deeplink) }
        }
    }
    
    static func didEndObservingDirectory(mbAddressName: String?) {
        // TODO: pass address folder name
        if let deeplink = URL(string: URL.deeplinkScheme + "?stop-monitoring") {
            DispatchQueue.main.async { NSWorkspace.shared.open(deeplink) }
        }
    }
    
    static func somethingChangedInHomeDirectory() {
        if let url = URL(string: URL.deeplinkScheme + "?check") { // TODO: clarify. do not ask for a check directly, notify of event instead
            DispatchQueue.main.async { NSWorkspace.shared.open(url) }
        }
    }
    
    private static func send(_ message: ExtensionMessage) {
        // TODO: implement
    }
    
}