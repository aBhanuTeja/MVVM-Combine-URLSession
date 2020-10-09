//
//  GetAnsweredByModel.swift
//  MVVMWithStackExchange
//
//  Created by Bhanuteja on 04/07/20.
//  Copyright © 2020 annam. All rights reserved.
//

import Foundation
import UIKit

struct GetAnsweredByResponse: Codable {
    let items: [GetAnsweredItemsData]

    enum CodingKeys: String, CodingKey {
        case items
    }
}

// MARK: - Item
struct GetAnsweredItemsData: Codable {
    let owner: GetAnsweredOwner?
    let score: Int?
    let creationDate: Int?

    enum CodingKeys: String, CodingKey {
        case owner
        case score
        case creationDate = "creation_date"
    }
    
    func questionCreationDate() -> String {
        return "Answered on \(Double(creationDate!).getDateStringFromUTC("MMM dd, yyy"))"
    }
}

// MARK: - Owner
struct GetAnsweredOwner: Codable {
    let reputation: Int?
    let profileImage: String?
    let displayName: String?

    enum CodingKeys: String, CodingKey {
        case reputation
        case profileImage = "profile_image"
        case displayName = "display_name"
    }
    
    func getProfileImage() -> UIImage {
        let imageUrl = URL(string: profileImage!)!
        let image = try? UIImage(withContentsOfUrl: imageUrl)
        return image!
    }
    
    func ownerReputations() -> String {
        return "Reputation: \(reputation ?? 0)"
    }
}
