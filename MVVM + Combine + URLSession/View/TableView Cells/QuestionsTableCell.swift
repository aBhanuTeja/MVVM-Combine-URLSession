//
//  QuestionsTableCell.swift
//  MVVMWithStackExchange
//
//  Created by Bhanuteja on 30/06/20.
//  Copyright © 2020 annam. All rights reserved.
//

import UIKit

class QuestionsTableCell: ReusableTableViewCell {
    
    @IBOutlet private weak var questionTitle: UILabel!
    @IBOutlet private weak var askedOnDate: UILabel!
    @IBOutlet private weak var ownerName: UILabel!
    @IBOutlet private weak var reputation: UILabel!
    @IBOutlet private weak var OwnerImage: UIImageView!
    @IBOutlet private weak var tagsLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setUpQuestionData(_ data: QuestionItemsData) {
        self.questionTitle.text = data.title
        self.askedOnDate.text = data.questionCreationDate()
        self.ownerName.text = data.owner?.displayName
        self.reputation.text = data.owner?.ownerReputations()
        self.tagsLbl.text = data.questionTags()
        self.OwnerImage.image = data.owner?.getProfileImage()
    }
}
