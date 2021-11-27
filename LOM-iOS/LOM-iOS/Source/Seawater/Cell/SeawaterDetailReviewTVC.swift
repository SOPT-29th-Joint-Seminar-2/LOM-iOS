//
//  SeawaterDetailReviewTVC.swift
//  LOM-iOS
//
//  Created by 김혜수 on 2021/11/15.
//

import UIKit

class SeawaterDetailReviewTVC: UITableViewCell {
    
    public static let identifier = "SeawaterDetailReviewTVC"

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUI() {
        dateLabel.textColor = .gray3
    }
    
    func setData(name: String, date: String, content: String) {
        nameLabel.text = name
        dateLabel.text = date
        contentLabel.text = content
    }

}
