// ∅ nft-folder 2024

import Foundation

struct Artblocks: Codable {
    let data: ArtblocksData
}

struct ArtblocksData: Codable {
    let projects: [Project]

    enum CodingKeys: String, CodingKey {
        case projects = "projects_metadata"
    }
}

struct Project: Codable {
    let projectId: String
    let contractAddress: String
    let curationStatus: String
    let name: String
    let tokens: [Token]

    enum CodingKeys: String, CodingKey {
        case projectId = "project_id"
        case contractAddress = "contract_address"
        case curationStatus = "curation_status"
        case name
        case tokens
    }
}

struct Token: Codable {
    let tokenId: String
    let videoId: Int?

    enum CodingKeys: String, CodingKey {
        case tokenId = "token_id"
        case videoId = "video_id"
    }
}
