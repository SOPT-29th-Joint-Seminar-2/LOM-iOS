import UIKit

class HomeVC: UIViewController {

    struct Banners {
        let title: String
        let subtitle: String
        let image: UIImage?
    }

    struct Books {
        let title: String
        let writer: String
        let image: UIImage?
    }
    
    // MARK: @IBOutlets
    @IBOutlet weak var pageScrollView: UIScrollView!
    @IBOutlet weak var pageView: UIView!
    @IBOutlet weak var bannerCollectionView: UICollectionView!

    @IBOutlet weak var todaysBookView: UIView!
    @IBOutlet weak var todaysBookLabel: UILabel!
    
    @IBOutlet weak var todaysBookImageView: UIImageView!
    @IBOutlet weak var timeIconImageView: UIImageView!
    @IBOutlet weak var timeExplainLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var verticalLineView: UIView!
    @IBOutlet weak var horizonLineView: UIView!
    @IBOutlet weak var saveIconImageView: UIImageView!
    @IBOutlet weak var saveBookButton: UIButton!
    @IBOutlet weak var pointOneImageView: UIImageView!
    @IBOutlet weak var pointTwoImageView: UIImageView!
    @IBOutlet weak var pointThreeImageView: UIImageView!

    @IBOutlet weak var moreInfoLabelOne: UILabel!
    @IBOutlet weak var moreInfoLabelTwo: UILabel!
    @IBOutlet weak var moreInfoLabelThree: UILabel!
    
    @IBOutlet weak var bestBookListTableView: UITableView!
    @IBOutlet weak var bestBookButton: UIButton!
    
    var mainBannerContentList: [Banner] = []
    var bestBookContentList: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initMainBannerContentList()
        initializeTodaysBookLayout()
        registerXib()
        bannerCollectionView.dataSource = self
        bannerCollectionView.delegate = self
        bannerCollectionView.isPagingEnabled = true
    }
    
    func registerXib(){
        let xibName = UINib(nibName: HomeBannerCVC.identifier, bundle: nil)
        bannerCollectionView.register(xibName, forCellWithReuseIdentifier: HomeBannerCVC.identifier)
    }
    
    func initializeTodaysBookLayout(){
        
        todaysBookView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
        todaysBookView.layer.cornerRadius = 10
        todaysBookView.layer.borderWidth = 1
        
        todaysBookLabel.text = "오늘의 책"
        todaysBookLabel.font = UIFont.NotoSans(.bold, size: 20)
        
        moreInfoLabelOne.font = UIFont.NotoSans(.medium, size: 13)
        moreInfoLabelTwo.font = UIFont.NotoSans(.medium, size: 13)
        moreInfoLabelThree.font = UIFont.NotoSans(.medium, size: 13)
        
        moreInfoLabelOne.textColor = .darkGray
        moreInfoLabelTwo.textColor = .darkGray
        moreInfoLabelThree.textColor = .darkGray
        
        timeExplainLabel.font = UIFont.NotoSans(.regular, size: 12)
        timeExplainLabel.textColor = .gray1
        
        timeLabel.font = UIFont.NotoSans(.medium, size: 14)
        timeLabel.textColor = .gray3
        
        saveBookButton.titleLabel?.font = UIFont.NotoSans(.medium, size: 14)
    }
    
    func initMainBannerContentList(){
        mainBannerContentList.append(contentsOf: [
            Banner(title: "SNS로 '진짜 나'를\n찾을 수 있을까", subtitle: "종이책 출간 전에 읽는 화제의 신작", image: Const.Image.bannerImg1),
            Banner(title: "11주 연속 베스트셀러\n김영하 북클럽 선정도서", subtitle: "11월 8일 커밍순!", image: Const.Image.bannerImg2),
            Banner(title: "영화와 책을 아우르는\n씨네21 칼럼니스트", subtitle: "이다혜 작가전 보러가기!", image: Const.Image.bannerImg3)
        ])
    }
    
    func initBestBookContentList(){
        //from server
    }
}

extension HomeVC: UICollectionViewDelegate {
    
}

extension HomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainBannerContentList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeBannerCVC.identifier, for: indexPath) as? HomeBannerCVC else {return UICollectionViewCell()}
        
        let nowData = mainBannerContentList[indexPath.row]
        
        cell.setData(page: indexPath.row+1, promote: nowData.title , explain: nowData.subtitle, bookImage: nowData.image)
        return cell
    }
    
}
