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

    enum CodingKeys: String, CodingKey {
        case items
    }
}

// MARK: - Item
struct QuestionItemsData: Codable {
    let tags: [String]?
    let owner: QuestionOwner?
    let creationDate: Int?
    let questionID: Int?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case tags, owner
        case creationDate = "creation_date"
        case questionID = "question_id"
        case title
    }

    func questionCreationDate() -> String {
        return "asked on \(Double(creationDate!).getDateStringFromUTC("MMM dd, yyy"))"
    }
    
    func questionTags() -> String {
        return tags?.joined(separator: ", ") ?? ""
    }
}

// MARK: - Owner
struct QuestionOwner: Codable {
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
