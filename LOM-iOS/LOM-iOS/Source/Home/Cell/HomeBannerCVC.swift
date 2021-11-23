import UIKit

class HomeBannerCVC: UICollectionViewCell {

    static let identifier = "HomeBannerCVC"
    
    // MARK: @IBOutlets
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var noticeImageView: UIImageView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var nowMenuLabel: UILabel!
    @IBOutlet weak var nowUnderBarView: UIView!
    @IBOutlet weak var audioMenuLabel: UILabel!
    @IBOutlet weak var storyMenuLabel: UILabel!
    
    @IBOutlet weak var optionImageView: UIImageView!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var promotionLabel: UILabel!
    @IBOutlet weak var explainLabel: UILabel!
    @IBOutlet weak var pageView: UIView!
    @IBOutlet weak var pageLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initializeLayout()
    }

    func initializeLayout(){
        pageView.clipsToBounds = true
        pageView.layer.cornerRadius = 16
        pageView.layer.borderWidth = 1
        pageView.layer.borderColor = UIColor(red: 0.239, green: 0.239, blue: 0.239, alpha: 1).cgColor
        pageLabel.textColor = .black
        promotionLabel.textColor = .black
        nowMenuLabel.textColor = .black
        audioMenuLabel.textColor = .black
        storyMenuLabel.textColor = .black
    }
    
    func setData(page: Int, promote: String, explain: String, bookImage: UIImage){
        pageLabel.text = "\(page) / 3"
        pageLabel.font = UIFont.NotoSans(.medium, size: 14)
        promotionLabel.text = promote
        explainLabel.text = explain
        bookImageView.image = bookImage
    }
}
