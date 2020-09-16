//
//  AnsweredByViewController.swift
//  MVVMWithStackExchange
//
//  Created by Bhanuteja on 04/07/20.
//  Copyright © 2020 annam. All rights reserved.
//

import UIKit
import Combine

class AnsweredByViewController: UIViewController {

    @IBOutlet weak var answeredByTableView: UITableView!

    private var getAnsweredByViewModel = GetAnsweredByViewModel()
    var selectedQuestion: QuestionItemsData?
    private var publisher = PassthroughSubject<Void,Never>()
    private var subscriptions = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAnswersData()
        AnsweredByTableCell.registerWithTableViewNib(answeredByTableView)
        QuestionsTableCell.registerWithTableViewNib(answeredByTableView)
        answeredByTableView.tableHeaderView = headerView()
        ActivityIndicator.sharedIndicator.showLoadingIndicator(onView: view)
        publisher.send()
    }

    private func fetchAnswersData() {
        getAnsweredByViewModel.getAnsweredByVM(questionID: selectedQuestion!.questionID!,
                                  answerData: publisher.eraseToAnyPublisher())

        getAnsweredByViewModel.reloadPlaceList
            .sink(receiveCompletion: { data in
                print(data)
        }) { [weak self] _ in
            ActivityIndicator.sharedIndicator.hideLoadingIndicator()
            self?.answeredByTableView.reloadData()
        }
        .store(in: &subscriptions)
    }
}

extension AnsweredByViewController: UITableViewDataSource, UITableViewDelegate {

    private func headerView() -> UIView {
        let cell = answeredByTableView.dequeueReusableCell(withIdentifier: QuestionsTableCell.reuseIdentifier) as! QuestionsTableCell
        cell.setUpQuestionData(selectedQuestion!)
        cell.backgroundColor = .clear
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getAnsweredByViewModel.numberOfRows
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Answered by:"
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AnsweredByTableCell.reuseIdentifier, for: indexPath) as! AnsweredByTableCell
        cell.setUpAnsweredByData(getAnsweredByViewModel.answersData[indexPath.row])
        return cell
    }
}
