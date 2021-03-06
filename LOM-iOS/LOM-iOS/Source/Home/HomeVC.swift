import UIKit

class HomeVC: UIViewController {

    // MARK: Whole Page @IBOutlets
    @IBOutlet weak var pageScrollView: UIScrollView!
    @IBOutlet weak var pageView: UIView!
    
    // MARK: CollectionView @IBOutlets
    @IBOutlet weak var bannerCollectionView: UICollectionView!

    // MARK: TodaysBookView @IBOutlets
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
    
    // MARK: TableView @IBOutlets
    @IBOutlet weak var bestBookLabel: UILabel!
    @IBOutlet weak var bestBookListTableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    var mainBannerContentList: [Banner] = []
    var bestBookContentList: [BestResultData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeFunctions()
    }
    
    func initializeFunctions(){
        getBestBookList()
        initMainBannerContentList()
        initializeBannerCollectionViewLayout()
        initializeTodaysBookLayout()
        registerXib()
        registerTableXib()
        bannerCollectionView.dataSource = self
        bannerCollectionView.delegate = self
        bestBookListTableView.dataSource = self
        bestBookListTableView.delegate = self
    }
    
    func registerXib(){
        let xibName = UINib(nibName: HomeBannerCVC.identifier, bundle: nil)
        bannerCollectionView.register(xibName, forCellWithReuseIdentifier: HomeBannerCVC.identifier)
    }
    
    func registerTableXib(){
        let xibName = UINib(nibName: HomeBestTVC.identifier, bundle: nil)
        bestBookListTableView.register(xibName, forCellReuseIdentifier: HomeBestTVC.identifier)
    }
    
    func initializeBannerCollectionViewLayout(){
        pageScrollView.showsVerticalScrollIndicator = false
        
        bannerCollectionView.isPagingEnabled = true
        bannerCollectionView.decelerationRate = .fast
        bannerCollectionView.contentInsetAdjustmentBehavior = .automatic
        bannerCollectionView.showsHorizontalScrollIndicator = false
        
        let layout = bannerCollectionView.collectionViewLayout as! UICollectionViewFlowLayout

        let cellHeight = bannerCollectionView.frame.height
        let cellWidth = UIScreen.main.bounds.size.width
    
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
    }
    
    func initializeTodaysBookLayout(){
        
        todaysBookView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
        todaysBookView.layer.cornerRadius = 10
        todaysBookView.layer.borderWidth = 1
        
        todaysBookLabel.text = "????????? ???"
        todaysBookLabel.font = UIFont.NotoSans(.bold, size: 20)
        
        bestBookLabel.font = UIFont.NotoSans(.bold, size: 20)
        
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
            Banner(title: "SNS??? '?????? ???'???\n?????? ??? ?????????", subtitle: "????????? ?????? ?????? ?????? ????????? ??????", image: Const.Image.bannerImg1),
            Banner(title: "11??? ?????? ???????????????\n????????? ????????? ????????????", subtitle: "11??? 8??? ?????????!", image: Const.Image.bannerImg2),
            Banner(title: "????????? ?????? ????????????\n??????21 ???????????????", subtitle: "????????? ????????? ????????????!", image: Const.Image.bannerImg3)
        ])
    }

}

extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return mainBannerContentList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeBannerCVC.identifier, for: indexPath) as? HomeBannerCVC else {return UICollectionViewCell()}
        
        let nowData = mainBannerContentList[indexPath.row]
        
        cell.setData(page: indexPath.row+1, promote: nowData.title , explain: nowData.subtitle, bookImage: nowData.image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = collectionView.frame.size.height
        let cellWidth = collectionView.frame.size.width
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("bestBookContentList.count : \(bestBookContentList.count)")
        
        return bestBookContentList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeBestTVC.identifier) as? HomeBestTVC else {return UITableViewCell()}
        
        let nowData = bestBookContentList[indexPath.row]
        
        cell.setData(rank: indexPath.row + 1, bookName: nowData.bookName, writerName: nowData.author, image: nowData.bookImg)
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            let storyboard = UIStoryboard.init(name: "Detail",bundle: nil)
            guard let nextVC = storyboard.instantiateViewController(withIdentifier: "DetailVC") as? DetailVC else {return}

            nextVC.receivedBookID = indexPath.row + 1
            nextVC.modalPresentationStyle = .fullScreen
            nextVC.modalTransitionStyle = .coverVertical

            present(nextVC, animated: true, completion: nil)
    }
}

extension HomeVC {
    func getBestBookList(){
        HomeInfoGetService.shared.readBestList{ responseData in
            
        switch responseData {
        case .success(let bestBookResponse):
            guard let response = bestBookResponse as? BestResponseData else {return}
            if let userData = response.data {
                self.bestBookContentList.append(contentsOf: userData)
                self.tableViewHeight.constant = CGFloat(104 * self.bestBookContentList.count)
                self.bestBookListTableView.reloadData()
            }
        case .requestErr(let msg):
            print("requestErr \(msg)")
        case .pathErr:
            print("pathErr")
        case .serverErr:
            print("serverErr")
        case .networkFail:
            print("networkFail")
        }
    }
    }
}
