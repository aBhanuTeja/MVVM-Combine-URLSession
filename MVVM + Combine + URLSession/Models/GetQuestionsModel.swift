//
//  getQuestionsModel.swift
//  MVVMWithStackExchange
//
//  Created by Bhanuteja on 30/06/20.
//  Copyright © 2020 annam. All rights reserved.
//

import Foundation
import UIKit

struct QuestionResponse: Codable {
    let items: [QuestionItemsData]
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
struct QuestionItemsData: Codable {
    let tags: [String]?
    let owner: QuestionOwner?
    let isAnswered: Bool?
    let viewCount: Int?
    let acceptedAnswerID: Int?
    let answerCount, score, lastActivityDate, creationDate: Int?
    let lastEditDate: Int?
    let questionID: Int?
    let contentLicense: ContentLicense?
    let link: String?
    let title: String?
    let closedDate: Int?
    let closedReason: String?

    enum CodingKeys: String, CodingKey {
        case tags, owner
        case isAnswered = "is_answered"
        case viewCount = "view_count"
        case acceptedAnswerID = "accepted_answer_id"
        case answerCount = "answer_count"
        case score
        case lastActivityDate = "last_activity_date"
        case creationDate = "creation_date"
        case lastEditDate = "last_edit_date"
        case questionID = "question_id"
        case contentLicense = "content_license"
        case link, title
        case closedDate = "closed_date"
        case closedReason = "closed_reason"
    }
    
    func questionCreationDate() -> String {
        return "asked on \(Double(creationDate!).getDateStringFromUTC("MMM dd, yyy"))"
    }
    
    func questionTags() -> String {
        return tags?.joined(separator: ", ") ?? ""
    }
}

enum ContentLicense: String, Codable {
    case ccBySa40 = "CC BY-SA 4.0"
}

// MARK: - Owner
struct QuestionOwner: Codable {
    let reputation, userID: Int?
    let userType: UserTypeData?
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

enum UserTypeData: String, Codable {
    case registered = "registered"
}
