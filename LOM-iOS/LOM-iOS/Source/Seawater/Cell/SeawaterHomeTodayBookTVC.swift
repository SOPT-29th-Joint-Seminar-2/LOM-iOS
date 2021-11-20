//
//  HomeTodayBookTVC.swift
//  LOM-iOS
//
//  Created by 김혜수 on 2021/11/16.
//

import UIKit

class SeawaterHomeTodayBookTVC: UITableViewCell {
    
    public static let identifier = "SeawaterHomeTodayBookTVC"

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var bookImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUI() {
        bgView.layer.cornerRadius = 12
        bgView.layer.borderColor = UIColor.lightGray1.cgColor
        bgView.layer.borderWidth = 1
    }
    
    func setData(image: UIImage) {
        bookImageView.image = image
    }

}
