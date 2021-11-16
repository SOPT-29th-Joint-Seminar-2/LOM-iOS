//
//  SeawaterHomeBannerCVC.swift
//  LOM-iOS
//
//  Created by 김혜수 on 2021/11/15.
//

import UIKit

class SeawaterHomeBannerCVC: UICollectionViewCell {
    
    static let identifier = "SeawaterHomeBannerCVC"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var bannerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }
    
    func setData(title: String, subtitle: String, image: UIImage) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        subtitleLabel.textColor = .gray2
        bannerImageView.image = image
    }
}
