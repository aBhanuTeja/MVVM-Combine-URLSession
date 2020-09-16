//
//  HomeViewController.swift
//  MVVMWithStackExchange
//
//  Created by Bhanuteja on 30/06/20.
//  Copyright © 2020 annam. All rights reserved.
//

import UIKit
import Combine

class HomeViewController: UIViewController {

    @IBOutlet weak var questionsTableView: UITableView!
    
    private var getQuestionViewModel = GetQuestionViewModel()
    private var publisher = PassthroughSubject<Void,Never>()
    private var subscriptions = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchQuestionsData()
        QuestionsTableCell.registerWithTableViewNib(questionsTableView)
        ActivityIndicator.sharedIndicator.showLoadingIndicator(onView: view)
        publisher.send()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func fetchQuestionsData() {
        getQuestionViewModel.getQuestionsListVM(questionData: publisher.eraseToAnyPublisher())
        
        getQuestionViewModel.reloadQuestionList
            .sink(receiveCompletion: { data in
            print(data)
        }) { [weak self] _ in
            ActivityIndicator.sharedIndicator.hideLoadingIndicator()
            self?.questionsTableView.reloadData()
        }
        .store(in: &subscriptions)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getQuestionViewModel.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuestionsTableCell.reuseIdentifier, for: indexPath) as! QuestionsTableCell
        cell.setUpQuestionData(getQuestionViewModel.questionsData[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let answeredByVC = self.storyboard?.instantiateViewController(identifier: "AnsweredByVC") as! AnsweredByViewController
        answeredByVC.selectedQuestion = getQuestionViewModel.questionsData[indexPath.row]
        self.navigationController?.pushViewController(answeredByVC, animated: true)
    }
}
