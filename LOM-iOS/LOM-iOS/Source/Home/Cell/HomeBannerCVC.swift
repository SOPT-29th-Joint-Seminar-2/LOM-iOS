import UIKit

class HomeBannerCVC: UICollectionViewCell {

    static let identifier = "HomeBannerCVC"
    
    // MARK: @IBOutlets
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var noticeImageView: UIImageView!
    @IBOutlet weak var menuImageView: UIImageView!
    @IBOutlet weak var optionImageView: UIImageView!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var promotionLabel: UILabel!
    @IBOutlet weak var explainLabel: UILabel!
    @IBOutlet weak var pageView: UIView!
    @IBOutlet weak var pageLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
