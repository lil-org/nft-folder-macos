// ∅ nft-folder 2024

import Foundation

struct MetadataStorage {
    
    private static let fileManager = FileManager.default
    
    static func detailedMetadata(nftFilePath: String) -> DetailedTokenMetadata? {
        if let fileId = fileId(path: nftFilePath), var url = URL.minimalMetadataDirectory(filePath: nftFilePath) {
            url.append(path: fileId)
            if let data = try? Data(contentsOf: url), let minimal = try? JSONDecoder().decode(MinimalTokenMetadata.self, from: data),
               var url = URL.detailedMetadataDirectory(filePath: nftFilePath) {
                url.append(path: fileNameCorrespondingTo(minimalMetadata: minimal))
                if let data = try? Data(contentsOf: url),
                   let metadata = try? JSONDecoder().decode(DetailedTokenMetadata.self, from: data) {
                    return metadata
                }
            }
        }
        return nil
    }
    
    static func recoverCollectionIfPossible(folderPath: String) -> WatchOnlyWallet? {
        print(folderPath)
        // TODO: attempt recover using metadata
        return nil
    }
    
    static func has(contentHash: UInt64, addressDirectoryURL: URL) -> Bool {
        if var url = URL.hashedMetadataDirectory(addressDirectoryURL: addressDirectoryURL) {
            url.append(path: String(contentHash))
            return fileManager.fileExists(atPath: url.path)
        } else {
            return false
        }
    }
    
    static func hasSomethingFor(detailedMetadata: DetailedTokenMetadata, addressDirectoryURL: URL) -> Bool {
        if var url = URL.detailedMetadataDirectory(addressDirectoryURL: addressDirectoryURL) {
            url.append(path: fileNameCorrespondingTo(minimalMetadata: detailedMetadata.minimalMetadata()))
            return fileManager.fileExists(atPath: url.path)
        } else {
            return false
        }
    }
    
    static func store(contentHash: UInt64, addressDirectoryURL: URL) {
        if var url = URL.hashedMetadataDirectory(addressDirectoryURL: addressDirectoryURL) {
            url.append(path: String(contentHash))
            try? Data().write(to: url)
        }
    }
    
    static func store(detailedMetadata: DetailedTokenMetadata, correspondingTo minimal: MinimalTokenMetadata, addressDirectoryURL: URL) {
        if let data = try? JSONEncoder().encode(detailedMetadata), var url = URL.detailedMetadataDirectory(addressDirectoryURL: addressDirectoryURL) {
            url.append(path: fileNameCorrespondingTo(minimalMetadata: minimal))
            try? data.write(to: url)
        }
    }
    
    static func store(minimalMetadata: MinimalTokenMetadata, filePath: String) {
        if let fileId = fileId(path: filePath),
           let data = try? JSONEncoder().encode(minimalMetadata),
           var url = URL.minimalMetadataDirectory(filePath: filePath) {
            url.append(path: fileId)
            try? data.write(to: url)
        }
    }
    
    static func minimalMetadata(filePath: String) -> MinimalTokenMetadata? {
        if let fileId = fileId(path: filePath), var url = URL.minimalMetadataDirectory(filePath: filePath) {
            url.append(path: fileId)
            if let data = try? Data(contentsOf: url),
               let metadata = try? JSONDecoder().decode(MinimalTokenMetadata.self, from: data) {
                return metadata
            }
        }
        return nil
    }
    
    static func nftURL(filePath: String, gallery: NftGallery) -> URL? {
        if let metadata = minimalMetadata(filePath: filePath) {
            return nftURL(metadata: metadata, gallery: gallery)
        } else {
            return nil
        }
    }
    
    private static func nftURL(metadata: MinimalTokenMetadata, gallery: NftGallery) -> URL? {
        let url = gallery.url(network: metadata.network, collectionAddress: metadata.collectionAddress, tokenId: metadata.tokenId)
        return url
    }
    
    private static func fileNameCorrespondingTo(minimalMetadata: MinimalTokenMetadata) -> String {
        return "\(minimalMetadata.network.rawValue)\(minimalMetadata.collectionAddress)\(minimalMetadata.tokenId)"
    }
    
    private static func fileId(path: String) -> String? {
        if let attributes = try? FileManager.default.attributesOfItem(atPath: path),
           let number = attributes[.systemFileNumber] as? UInt {
            return String(number)
        } else {
            return nil
        }
    }
    
}
