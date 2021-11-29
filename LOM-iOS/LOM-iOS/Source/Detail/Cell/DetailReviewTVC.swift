//
//  DetailReviewTVC.swift
//  LOM-iOS
//
//  Created by 김혜수 on 2021/11/13.
//

import UIKit

class DetailReviewTVC: UITableViewCell {
    static let identifier = "DetailReviewTVC"
    var reviewIdTransfer = -1

    @IBOutlet weak var profileIV: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var likeUIVIew: UIView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setUIView() {
        likeUIVIew.layer.cornerRadius = 13
        likeUIVIew.layer.borderWidth = 1
        likeUIVIew.layer.borderColor = UIColor(red: 0.757, green: 0.757, blue: 0.757, alpha: 1).cgColor
    }
    
    @IBAction func tapToRaiseCount(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("sendReviewId"), object: reviewIdTransfer, userInfo: nil)
    }
    
    func setData(appData: detailReviewTVData) {
        usernameLabel.text = "\(appData.username)·"
        dateLabel.text = appData.date
        reviewLabel.text = appData.review
        profileIV.image = appData.makeImage()
        likeLabel.text = String(appData.likeCount)
        reviewIdTransfer = appData.reviewId
        if(appData.updatedLike == 0){
            setUIView()
        } else{
            setUIView()
            let filledImage = UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .medium)
            likeButton.tintColor = .black
            likeButton.setImage(UIImage(systemName: "suit.heart.fill", withConfiguration: filledImage), for: .normal)
            likeButton.tintColor = .black
            likeUIVIew.layer.borderColor = UIColor.black.cgColor
            likeLabel.textColor = .black
        }
    }
}
