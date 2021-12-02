//
//  SeawaterHomeBestTVC.swift
//  LOM-iOS
//
//  Created by 김혜수 on 2021/11/15.
//

import UIKit

class SeawaterHomeBestTVC: UITableViewCell {
    
    public static let identifier = "SeawaterHomeBestTVC"
    
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(rank: Int, image: String, title: String, writer: String) {
        rankLabel.text = "\(rank)"
        guard let url = URL(string: image) else {
            return
        }
        let data = try? Data(contentsOf: url)
        DispatchQueue.main.async {
            self.bookImageView.image = UIImage(data: data!)
        }
    
        titleLabel.text = title
        writerLabel.text = writer
    }
    
}
