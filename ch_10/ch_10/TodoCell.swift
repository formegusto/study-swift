//
//  TodoCell.swift
//  ch_10
//
//  Created by formegusto on 2021/12/05.
//

import UIKit

class TodoCell: UITableViewCell {

    @IBOutlet weak var priorityBox: UIView!
    @IBOutlet weak var topTitleLabel: UILabel!
    @IBOutlet weak var bottomDateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
