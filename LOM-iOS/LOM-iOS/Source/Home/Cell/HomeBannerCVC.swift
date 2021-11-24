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
        pageLabel.textColor = .init(red: 0.239, green: 0.239, blue: 0.239, alpha: 1)

        promotionLabel.textColor = .black
        nowMenuLabel.textColor = .black
        nowMenuLabel.font = UIFont.Lato(.bold, size: 16)
        
        audioMenuLabel.textColor = UIColor(red: 0.435, green: 0.435, blue: 0.435, alpha: 1)
        storyMenuLabel.textColor = UIColor(red: 0.435, green: 0.435, blue: 0.435, alpha: 1)
        audioMenuLabel.font = UIFont.Lato(.regular, size: 16)
        storyMenuLabel.font = UIFont.Lato(.regular, size: 16)
        
        backgroundImageView.contentMode = .scaleToFill
        backgroundImageView.clipsToBounds = false
        backgroundImageView.sizeToFit()
    }
    
    func setData(page: Int, promote: String, explain: String, bookImage: UIImage){
        pageLabel.text = "\(page) / 3 >"
        pageLabel.font = UIFont.NotoSans(.medium, size: 14)
        promotionLabel.text = promote
        explainLabel.text = explain
        bookImageView.image = bookImage
        
        self.addSubview(bookImageView)
        bookImageView.clipsToBounds = false
        bookImageView.translatesAutoresizingMaskIntoConstraints = false
        bookImageView.contentMode = .bottomRight

        switch page {
        case 1:
            backgroundImageView.image = UIImage(named: "Rectangle 103")

            NSLayoutConstraint.init(item: bookImageView, attribute: .bottom, relatedBy: .equal, toItem: backgroundImageView, attribute: .bottom, multiplier: 1.0, constant: 15).isActive = true
            NSLayoutConstraint.init(item: bookImageView, attribute: .leading, relatedBy: .equal, toItem: backgroundImageView, attribute: .leading, multiplier: 1.0, constant: 203).isActive = true



        case 2:
            backgroundImageView.image = UIImage(named: "Rectangle 104")

            NSLayoutConstraint.init(item: bookImageView, attribute: .bottom, relatedBy: .equal, toItem: backgroundImageView, attribute: .bottom, multiplier: 1.0, constant: 15).isActive = true
            NSLayoutConstraint.init(item: bookImageView, attribute: .leading, relatedBy: .equal, toItem: backgroundImageView, attribute: .leading, multiplier: 1.0, constant: 200).isActive = true

        case 3:
            backgroundImageView.image = UIImage(named: "Rectangle 105")

            NSLayoutConstraint.init(item: bookImageView, attribute: .bottom, relatedBy: .equal, toItem: backgroundImageView, attribute: .bottom, multiplier: 1.0, constant: 20).isActive = true
            NSLayoutConstraint.init(item: bookImageView, attribute: .leading, relatedBy: .equal, toItem: backgroundImageView, attribute: .leading, multiplier: 1.0, constant: 225).isActive = true

        default:
            backgroundImageView.image = UIImage(named: "Rectangle 103")
        }
    }
}
