//
//  DetailVC.swift
//  LOM-iOS
//
//  Created by 김혜수 on 2021/11/13.
//

import UIKit
import SkeletonView

class DetailVC: UIViewController {

    @IBOutlet weak var detailReviewTV: UITableView!
    @IBOutlet weak var reviewPostButton: UIButton!
    @IBOutlet weak var reviewContentView: UIView!
    @IBOutlet weak var segmentedControlBackView: UIView!
    
    @IBOutlet weak var completePercentLabel: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var userStorageLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var reviewPointLabel: UILabel!
    @IBOutlet weak var postCountLabel: UILabel!
    @IBOutlet weak var bookInfoDescriptionLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var postSizeLabel: UILabel!

    public var reviewTransfer = -1
    
    var detailTVContentList: [detailReviewTVData] = []{
        didSet{
            NotificationCenter.default.post(name: NSNotification.Name("TestNotification"), object: nil, userInfo: nil)
        }
    }
    func loadTableViewData(){
        NotificationCenter.default.addObserver(self, selector: #selector(dataRecieved), name: NSNotification.Name("TestNotification"), object:nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reviewIdRecieved), name: NSNotification.Name("sendReviewId"), object:nil)
    }
    
    @objc func dataRecieved(notification: NSNotification){
        if detailTVContentList.count == reviewTransfer {
            self.detailReviewTV.reloadData()
        }
    }
    
    @objc func reviewIdRecieved(notification: NSNotification){
        reviewNumber = notification.object as! Int
        putLikeCount()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBasicLayout()
        registerXib()
        detailReviewTV.delegate = self
        detailReviewTV.dataSource = self
        setSegmentedControl()
        getUserData()
        loadTableViewData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        bookNameLabel.isSkeletonable = true
        
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.view.hideSkeleton() // Hide Skeleton
        }
    }
    
    func setSegmentedControl() {
        let array: [String] = ["전자책", "오디오북"]
        let sc = CustomSegmentedControl(items: array)
        sc.frame = CGRect(x: 50, y: 400, width: 165, height: 41)
        sc.center = CGPoint(x: self.segmentedControlBackView.frame.width/2, y: self.segmentedControlBackView.frame.height/2)
        sc.backgroundColor = UIColor.lightGray1
        sc.tintColor = UIColor.white
        sc.selectedSegmentIndex = 0
        self.segmentedControlBackView.addSubview(sc)
    }
    
    func setBasicLayout() {
        reviewPostButton.layer.cornerRadius = 8
        reviewContentView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        reviewContentView.layer.cornerRadius = 8
        reviewContentView.layer.borderWidth = 1
        reviewContentView.layer.borderColor = UIColor(red: 0.757, green: 0.757, blue: 0.757, alpha: 1).cgColor
    }
    
    // MARK: - Navigation
    func registerXib(){
        let xibTableViewName = UINib(nibName: DetailReviewTVC.identifier, bundle: nil)
        detailReviewTV.register(xibTableViewName, forCellReuseIdentifier: DetailReviewTVC.identifier)
    }
    
    
    @IBAction func swipeGesture(_ sender: UISwipeGestureRecognizer) {
        self.modalTransitionStyle = .crossDissolve
        self.dismiss(animated: true, completion: nil)
    }
    
    public var updateCount : Int = 0 {
        didSet {
            getReviewLikeData()
            print("1")
            detailReviewTV.reloadData()
        }
    }
    
    public var bookNumber : Int = 1
    public let num = Int.random(in: 1...4)
    public var reviewNumber : Int = -1
}

extension DetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 119
    }
}

extension DetailVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailTVContentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailReviewTVC.identifier) as? DetailReviewTVC else {return UITableViewCell()}
        
        cell.setData(appData: detailTVContentList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

struct detailReviewTVData{
    let username: String
    let date: String
    let review: String
    let imageName: String
    var likeCount: Int
    var updatedLike: Int
    let reviewId: Int
    
    func makeImage() -> UIImage? {
        return UIImage(named: imageName)
    }
}

extension DetailVC{
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
                            self.bookImageView.image = UIImage(data: data!)
                        }
                    }
                    self.completePercentLabel.text = "완독할 확률 \(completePercent)%"
                    self.completePercentLabel.sizeToFit()
                    let reviewCount = userData.reviewList.count
                    self.reviewTransfer = reviewCount
                    self.reviewCountLabel.text = "\(reviewCount)개"
                    self.authorLabel.text = userData.bookInfoList.author
                    self.authorLabel.sizeToFit()
                    self.userStorageLabel.text = userData.bookInfoList.userStorage
                    self.userStorageLabel.sizeToFit()
                    self.bookInfoDescriptionLabel.text = userData.bookInfoList.bookInfoListDescription
                    self.bookInfoDescriptionLabel.sizeToFit()
                    self.bookNameLabel.text = userData.bookInfoList.bookName
                    self.bookNameLabel.sizeToFit()
                    self.categoryLabel.text = userData.bookInfoList.category
                    self.categoryLabel.sizeToFit()
                    self.reviewPointLabel.text = String(userData.bookInfoList.reviewPoint) + "P"
                    self.reviewPointLabel.sizeToFit()
                    self.postSizeLabel.text = userData.bookInfoList.postSize
                    self.postSizeLabel.sizeToFit()
                    
                    for i in 0...(reviewCount-1){
                        self.detailTVContentList.append(contentsOf: [
                            detailReviewTVData(username: userData.reviewList[i].nickname, date: userData.reviewList[i].createdAt ?? "2021.11.05", review: userData.reviewList[i].contents, imageName: "Profile", likeCount: userData.reviewList[i].likeCount, updatedLike: 0, reviewId:userData.reviewList[i].id)
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
    
    func putLikeCount() {
        ReviewLikeService.shared.putLikeCount(reviewId: reviewNumber) { responseData in
            switch responseData {
            case .success:
                self.updateCount += 1
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
    
    func getReviewLikeData() {
        detailInfoGetService.shared.readUserData(bookId: num) { responseData in
            switch responseData {
            case .success(let BookInfoResponse):
                guard let response = BookInfoResponse as?
                        DetailResponseData else {return}
                if let userData = response.data {
                    self.detailTVContentList[self.reviewNumber-1].likeCount = userData.reviewList[self.reviewNumber-1].likeCount
                    self.detailTVContentList[self.reviewNumber-1].updatedLike += 1
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
