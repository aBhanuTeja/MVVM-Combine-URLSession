//
//  InteractionManager.swift
//  SampleMVVMwithURLSession
//
//  Created by Bhanuteja on 30/06/20.
//  Copyright © 2020 Bhanu. All rights reserved.
//

import Foundation
import Combine

struct InteractionManager {

    func getQuestionsListIM() -> AnyPublisher<[QuestionItemsData], NetworkError> {
        let url = APIURL.getAllQuestions.apiString
        let placeResponsePublisher: AnyPublisher<QuestionResponse, NetworkError> = RequestManager.sharedService.requestAPI(requestType: .GET, urlString: url)
        return placeResponsePublisher
            .map { $0.items }
            .eraseToAnyPublisher()
    }

    func getAnsweredByIM(questionID: Int) -> AnyPublisher<[GetAnsweredItemsData], NetworkError> {
        let url = APIURL.BASE_URL + "/\(questionID)" + APIURL.getAnsweredBy.apiString
        let placeResponsePublisher: AnyPublisher<GetAnsweredByResponse, NetworkError> = RequestManager.sharedService.requestAPI(requestType: .GET, urlString: url)
        return placeResponsePublisher
            .map { $0.items }
            .eraseToAnyPublisher()
    }
}
