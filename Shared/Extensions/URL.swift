// ∅ nft-folder-macos 2024

import Cocoa

extension URL {
    
    static let ipfsScheme = "ipfs://"
    static let arScheme = "ar://"
    static let deeplinkScheme = "nft-folder://"
    
    static func nftDirectory(wallet: WatchOnlyWallet, createIfDoesNotExist: Bool) -> URL? {
        let fileManager = FileManager.default
        guard let addressDirectoryURL = nftDirectory?.appendingPathComponent(wallet.displayName) else { return nil }
        if !fileManager.fileExists(atPath: addressDirectoryURL.path) {
            if createIfDoesNotExist {
                try? fileManager.createDirectory(at: addressDirectoryURL, withIntermediateDirectories: true, attributes: nil)
            } else {
                return nil
            }
        }
        return addressDirectoryURL
    }
    
    static func metadataDirectory(filePath: String) -> URL? {
        // TODO: when keeping inside of a separate directory, make sure that that separate directory exists, and only then create .nft when needed
        let fileManager = FileManager.default
        guard let metadataDirectoryURL = nftDirectory?.appendingPathComponent(".nft") else { return nil }
        if !fileManager.fileExists(atPath: metadataDirectoryURL.path) {
            try? fileManager.createDirectory(at: metadataDirectoryURL, withIntermediateDirectories: true, attributes: nil)
        }
        return metadataDirectoryURL
    }
    
    static var nftDirectory: URL? {
        let fileManager = FileManager.default
        let musicDirectoryURL = fileManager.urls(for: .musicDirectory, in: .userDomainMask).first
        guard let nftDirectoryURL = musicDirectoryURL?.appendingPathComponent("nft") else { return nil }
        
        if !fileManager.fileExists(atPath: nftDirectoryURL.path) {
            try? fileManager.createDirectory(at: nftDirectoryURL, withIntermediateDirectories: true, attributes: nil)
        }
        
        return nftDirectoryURL
    }
    
}
