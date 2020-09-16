//
//  AnsweredByTableCell.swift
//  MVVMWithStackExchange
//
//  Created by Bhanuteja on 04/07/20.
//  Copyright © 2020 annam. All rights reserved.
//

import UIKit

class AnsweredByTableCell: ReusableTableViewCell {

    @IBOutlet private weak var ownerName: UILabel!
    @IBOutlet private weak var reputation: UILabel!
    @IBOutlet private weak var OwnerImage: UIImageView!
    @IBOutlet private weak var answeredOn: UILabel!
    @IBOutlet private weak var scoreGained: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setUpAnsweredByData(_ data: GetAnsweredItemsData) {
        self.ownerName.text = data.owner?.displayName
        self.reputation.text = data.owner?.ownerReputations()
        self.OwnerImage.image = data.owner?.getProfileImage()
        self.answeredOn.text = data.questionCreationDate()
        self.scoreGained.text = "Score: \(data.score ?? 0)"
    }
}
