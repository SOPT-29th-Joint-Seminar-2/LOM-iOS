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
    
    var mainBannerContentList: [Banner] = []
    var bestBookContentList: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initMainBannerContentList()
        initializeBannerCollectionViewLayout()
        initializeTodaysBookLayout()
        initBestBookContentList()
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
        
        todaysBookLabel.text = "오늘의 책"
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
            Banner(title: "SNS로 '진짜 나'를\n찾을 수 있을까", subtitle: "종이책 출간 전에 읽는 화제의 신작", image: Const.Image.bannerImg1),
            Banner(title: "11주 연속 베스트셀러\n김영하 북클럽 선정도서", subtitle: "11월 8일 커밍순!", image: Const.Image.bannerImg2),
            Banner(title: "영화와 책을 아우르는\n씨네21 칼럼니스트", subtitle: "이다혜 작가전 보러가기!", image: Const.Image.bannerImg3)
        ])
    }
    
    func initBestBookContentList(){
        bestBookContentList.append(contentsOf: [
            Book(title: "달러구트 꿈 백화점 2", writer: "이미예(지은이)", image: Const.Image.bestImg4)
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
        return bestBookContentList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeBestTVC.identifier) as? HomeBestTVC else {return UITableViewCell()}
        
        let nowData = bestBookContentList[indexPath.row]
        
        cell.setData(rank: indexPath.row + 1, bookName: nowData.title, writerName: nowData.writer, image: nowData.image)
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 0){
            let storyboard = UIStoryboard.init(name: "Detail",bundle: nil)
            guard let nextVC = storyboard.instantiateViewController(withIdentifier: "DetailVC") as? DetailVC else {return}

            nextVC.modalPresentationStyle = .fullScreen
            nextVC.modalTransitionStyle = .coverVertical
            
            let num = Int.random(in: 1...4)
            
            func getUserData() {
                detailInfoGetService.shared.readUserData(bookId: num) { responseData in
                    switch responseData {
                    case .success(let BookInfoResponse):
                        guard let response = BookInfoResponse as?
                                DetailResponseData else {return}
                        if let userData = response.data {
                            let completePercent = String(userData.bookInfoList.completePercent)
                            let url = URL(string: userData.bookInfoList.bookImg)
                            DispatchQueue.global().async {
                                let data = try? Data(contentsOf: url!)
                                DispatchQueue.main.async {
                                    nextVC.bookImageView.image = UIImage(data: data!)
                                }
                            }
                            nextVC.completePercentLabel.text = "완독할 확률 \(completePercent)%"
                            nextVC.completePercentLabel.sizeToFit()
                            let reviewCount = userData.reviewList.count
                            nextVC.reviewTransfer = reviewCount
                            nextVC.reviewCountLabel.text = "\(reviewCount)개"
                            nextVC.authorLabel.text = userData.bookInfoList.author
                            nextVC.authorLabel.sizeToFit()
                            nextVC.userStorageLabel.text = userData.bookInfoList.userStorage
                            nextVC.userStorageLabel.sizeToFit()
                            nextVC.bookInfoDescriptionLabel.text = userData.bookInfoList.bookInfoListDescription
                            nextVC.bookInfoDescriptionLabel.sizeToFit()
                            nextVC.bookNameLabel.text = userData.bookInfoList.bookName
                            nextVC.bookNameLabel.sizeToFit()
                            nextVC.categoryLabel.text = userData.bookInfoList.category
                            nextVC.categoryLabel.sizeToFit()
                            nextVC.reviewPointLabel.text = String(userData.bookInfoList.reviewPoint) + "P"
                            nextVC.reviewPointLabel.sizeToFit()
                            nextVC.postSizeLabel.text = userData.bookInfoList.postSize
                            nextVC.postSizeLabel.sizeToFit()
                            
                            for i in 0...(reviewCount-1){
                                nextVC.detailTVContentList.append(contentsOf: [
                                    detailReviewTVData(username: userData.reviewList[i].nickname, date: userData.reviewList[i].createdAt ?? "2021.11.05", review: userData.reviewList[i].contents, imageName: "Profile", likeCount: userData.reviewList[i].likeCount)
                                ])
                            }
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
            getUserData()
            
            present(nextVC, animated: true, completion: nil)
        }
    }
}
