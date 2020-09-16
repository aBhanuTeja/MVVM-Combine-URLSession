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
    let hasMore: Bool?
    let quotaMax, quotaRemaining: Int?

    enum CodingKeys: String, CodingKey {
        case items
        case hasMore = "has_more"
        case quotaMax = "quota_max"
        case quotaRemaining = "quota_remaining"
    }
}

// MARK: - Item
struct GetAnsweredItemsData: Codable {
    let owner: GetAnsweredOwner?
    let isAccepted: Bool?
    let score, lastActivityDate: Int?
    let lastEditDate: Int?
    let creationDate, answerID, questionID: Int?
    let contentLicense: String?

    enum CodingKeys: String, CodingKey {
        case owner
        case isAccepted = "is_accepted"
        case score
        case lastActivityDate = "last_activity_date"
        case lastEditDate = "last_edit_date"
        case creationDate = "creation_date"
        case answerID = "answer_id"
        case questionID = "question_id"
        case contentLicense = "content_license"
    }
    
    func questionCreationDate() -> String {
        return "Answered on \(Double(creationDate!).getDateStringFromUTC("MMM dd, yyy"))"
    }
}

// MARK: - Owner
struct GetAnsweredOwner: Codable {
    let reputation, userID: Int?
    let userType: String?
    let profileImage: String?
    let displayName: String?
    let link: String?
    let acceptRate: Int?

    enum CodingKeys: String, CodingKey {
        case reputation
        case userID = "user_id"
        case userType = "user_type"
        case profileImage = "profile_image"
        case displayName = "display_name"
        case link
        case acceptRate = "accept_rate"
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
