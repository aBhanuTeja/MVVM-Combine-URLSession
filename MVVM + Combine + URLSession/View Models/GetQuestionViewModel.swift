//
//  GetQuestionsVM.swift
//  MVVM + Combine + URLSession
//
//  Created by Bhanuteja on 13/07/20.
//  Copyright © 2020 annam. All rights reserved.
//

import Foundation
import Combine

class GetQuestionViewModel {
    
    private var getQuestionPublisher: AnyPublisher<Void, Never> = PassthroughSubject<Void, Never>().eraseToAnyPublisher()
    private let reloadQuestionDataSubject = PassthroughSubject<Result<Void, NetworkError>, Never>()
    private var subscriptions = Set<AnyCancellable>()
    var questionsData = [QuestionItemsData]()
    var numberOfRows = 0

    var reloadQuestionList: AnyPublisher<Result<Void, NetworkError>, Never> {
        reloadQuestionDataSubject.eraseToAnyPublisher()
    }

    func getQuestionsListVM(questionData: AnyPublisher<Void, Never>) {
        self.getQuestionPublisher = questionData
        self.getQuestionPublisher
            .setFailureType(to: NetworkError.self)
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.questionsData.removeAll()
            })
            .flatMap { _ -> AnyPublisher<[QuestionItemsData], NetworkError> in
                return InteractionManager().getQuestionsListIM()
            }
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.questionsData.removeAll()
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] result in
                self?.prepareTableDataSource(response: result)
            })
            .store(in: &subscriptions)
    }

    private func prepareTableDataSource(response: [QuestionItemsData]) {
        questionsData = response
        numberOfRows = response.count
        reloadQuestionDataSubject.send(.success(()))
    }
}
