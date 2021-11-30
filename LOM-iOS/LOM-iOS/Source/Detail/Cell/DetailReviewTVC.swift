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
    var staticReviewId = -1

    @IBOutlet weak var profileIV: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var likeUIVIew: UIView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var bestLabel: UILabel!
    
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
        let filledImage = UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .medium)
        likeButton.tintColor = .gray2
        likeButton.setImage(UIImage(systemName: "suit.heart", withConfiguration: filledImage), for: .normal)
        likeButton.tintColor = .gray2
        likeLabel.textColor = .gray2
    }
    
    @IBAction func tapToRaiseCount(_ sender: Any) {
        print("버튼클릭 수")
        setNotification()
        
        NotificationCenter.default.post(name: NSNotification.Name("reviewLikeReload"), object: nil, userInfo: nil)
    }
    
    func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(dataTransfer), name: NSNotification.Name("1"), object:nil)
    }
    
    @objc func dataTransfer(notification: NSNotification){
        NotificationCenter.default.post(name: NSNotification.Name("sendstaticReviewId"), object: staticReviewId, userInfo: nil)
        
        NotificationCenter.default.post(name: NSNotification.Name("sendReviewId"), object: reviewIdTransfer, userInfo: nil)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    func setData(appData: detailReviewTVData) {
        if appData.rank <= 2 {
            usernameLabel.text = "\(appData.username)·"
            bestLabel.text = "Best"
        } else {
            usernameLabel.text = "\(appData.username)"
            bestLabel.text = ""
        }
        dateLabel.text = appData.date
        reviewLabel.text = appData.review
        profileIV.image = appData.makeImage()
        likeLabel.text = String(appData.likeCount)
        staticReviewId = appData.staticReviewId
        
        reviewIdTransfer = appData.rank
        
        setUIView()
        
        if(appData.updatedLike != 0) {
            let filledImage = UIImage.SymbolConfiguration(pointSize: 17, weight: .bold, scale: .medium)
            likeButton.tintColor = .black
            likeButton.setImage(UIImage(systemName: "suit.heart.fill", withConfiguration: filledImage), for: .normal)
            likeButton.tintColor = .black
            likeUIVIew.layer.borderColor = UIColor.black.cgColor
            likeLabel.textColor = .black
        }
    }
}
