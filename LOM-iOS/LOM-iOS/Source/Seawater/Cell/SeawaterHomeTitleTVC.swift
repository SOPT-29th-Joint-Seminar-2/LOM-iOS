//
//  SeawaterHomeTitleTVC.swift
//  LOM-iOS
//
//  Created by 김혜수 on 2021/11/16.
//

import UIKit

class SeawaterHomeTitleTVC: UITableViewCell {
    
    public static let identifier = "SeawaterHomeTitleTVC"

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(title: String) {
        titleLabel.text = title
    }

}
