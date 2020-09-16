//
//  NetworkTypes.swift
//  The App for Movie
//
//  Created by Bhanuteja on 16/02/20.
//  Copyright © 2020 annam. All rights reserved.
//

import Foundation

enum APIURL {
    static let BASE_URL = "https://api.stackexchange.com/2.2/questions"
    static let SITE = "site=stackoverflow"

    case getAllQuestions
    case getAnsweredBy

    var apiString: String {
        switch self {
        case .getAllQuestions:
            return APIURL.BASE_URL + "?order=desc&sort=week&" + APIURL.SITE
        case .getAnsweredBy:
            return "/answers?order=desc&sort=votes&" + APIURL.SITE
        }
    }
}
