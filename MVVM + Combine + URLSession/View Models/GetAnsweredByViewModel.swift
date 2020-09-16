//
//  GetAnsweredByViewModel.swift
//  MVVM + Combine + URLSession
//
//  Created by Bhanuteja on 17/07/20.
//  Copyright © 2020 annam. All rights reserved.
//

import Foundation
import Combine

class GetAnsweredByViewModel {

    private var getAnswerPublisher: AnyPublisher<Void, Never> = PassthroughSubject<Void, Never>().eraseToAnyPublisher()
    private let reloadAnswerDataSubject = PassthroughSubject<Result<Void, NetworkError>, Never>()
    private var subscriptions = Set<AnyCancellable>()
    var answersData = [GetAnsweredItemsData]()
    var numberOfRows = 0

    var reloadPlaceList: AnyPublisher<Result<Void, NetworkError>, Never> {
        reloadAnswerDataSubject.eraseToAnyPublisher()
    }

    func getAnsweredByVM(questionID: Int, answerData: AnyPublisher<Void, Never>) {
        self.getAnswerPublisher = answerData
        self.getAnswerPublisher
            .setFailureType(to: NetworkError.self)
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.answersData.removeAll()
            })
            .flatMap { _ -> AnyPublisher<[GetAnsweredItemsData], NetworkError> in
                return InteractionManager().getAnsweredByIM(questionID: questionID)
            }
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.answersData.removeAll()
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] result in
                self?.prepareTableDataSource(response: result)
            })
            .store(in: &subscriptions)
    }

    private func prepareTableDataSource(response: [GetAnsweredItemsData]) {
        answersData = response
        numberOfRows = response.count
        reloadAnswerDataSubject.send(.success(()))
    }
}
