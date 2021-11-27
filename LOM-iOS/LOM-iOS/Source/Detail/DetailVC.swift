//
//  DetailVC.swift
//  LOM-iOS
//
//  Created by 김혜수 on 2021/11/13.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var detailReviewTV: UITableView!
    @IBOutlet weak var reviewPostButton: UIButton!
    @IBOutlet weak var reviewContentView: UIView!
    @IBOutlet weak var segmentedControlBackView: UIView!
    
    @IBOutlet weak var completePercentLabel: UILabel!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var userStorageLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var reviewPointLabel: UILabel!
    @IBOutlet weak var postCountLabel: UILabel!
    @IBOutlet weak var bookInfoDescriptionLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var postSizeLabel: UILabel!

    var detailTVContentList: [detailReviewTVData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBasicLayout()
        registerXib()
        detailReviewTV.delegate = self
        detailReviewTV.dataSource = self
        initItemTVContentList()
        setSegmentedControl()
        getUserData()
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
    
    func initItemTVContentList() {
        detailTVContentList.append(contentsOf: [
            detailReviewTVData(username: "아요짱", date: "2021.11.05", review: "책보면서 먹는 사과가 젤 맛있쪙!", imageName: "Profile", likeCount: 1),                                    detailReviewTVData(username: "안드킹", date: "2021.11.05", review: "페니가 성장한 만큼, 저도 성장한 기분이었습니다.", imageName: "Profile", likeCount: 2)
            //            ItemTVData(item: "거베라",location: "관악구", imageName: ["1-1", "1-2","1-3","1-4"], time: "1시 5분", chats: 2, hearts: 3, price: "10,000원", content: "팝니다 팔아요. 뭐라고 해야 잘 팔릴지 모르겠어서 일단 분량만 채워둡니다. 쿠리보가 직접 판매하는 배터리 두개 엘지 무선청소기. 최은주가 부릅니다 래원의 느린심장박동", views: 132, category: "꽃"),
            //            ItemTVData(item: "수국 팔아요",location: "중랑구", imageName: ["2-1", "2-2", "2-3","2-4","2-5"], time: "2시 13분", chats: 2, hearts: 3, price: "5,000원", content: "팝니다 팔아요. 뭐라고 해야 잘 팔릴지 모르겠어서 일단 분량만 채워둡니다. 쿠리보가 직접 판매하는 배터리 두개 엘지 무선청소기. 최은주가 부릅니다 래원의 느린심장박동", views: 234, category: "꽃")
        ])
    }
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
//        let homeItemSB = UIStoryboard.init(name: "HomeItemSB", bundle:nil)
//
//        guard let nextVC = homeItemSB.instantiateViewController(identifier: "HomeItemVC") as? HomeItemVC else {return}
//
//        //
//        nextVC.itemIndex = indexPath.row
//        nextVC.itemTVContentList = itemTVContentList
//
//        // 화면전환
//        nextVC.modalPresentationStyle = .fullScreen
//        self.navigationController?.pushViewController(nextVC, animated: true)
        
//        TV.separatorInset = UIEdgeInsets(top: , left: , bottom: , right: )
    }
}

struct detailReviewTVData{
    let username: String
    let date: String
    let review: String
    let imageName: String
    let likeCount: Int
    
    func makeImage() -> UIImage? {
        return UIImage(named: imageName)
    }
}

class CustomSegmentedControl: UISegmentedControl{
    private let segmentInset: CGFloat = 5       //your inset amount
    private let segmentImage: UIImage? = UIImage(color: UIColor.white)    //your color

    override func layoutSubviews(){
        super.layoutSubviews()
        //background
        layer.cornerRadius = bounds.height/2
        //foreground
        let foregroundIndex = numberOfSegments
        if subviews.indices.contains(foregroundIndex),  let foregroundImageView = subviews[foregroundIndex] as? UIImageView
        {
            foregroundImageView.bounds = foregroundImageView.bounds.insetBy(dx: segmentInset, dy: segmentInset)
            foregroundImageView.image = segmentImage    //substitute with our own colored image
            foregroundImageView.layer.removeAnimation(forKey: "SelectionBounds")    //this removes the weird scaling animation!
            foregroundImageView.layer.masksToBounds = true
            foregroundImageView.layer.cornerRadius = foregroundImageView.bounds.height/2
//            foregroundImageView.layer.shadowColor = UIColor.black.cgColor
//            foregroundImageView.layer.shadowOffset = CGSize(width: 0, height: 4)
//            foregroundImageView.layer.shadowRadius = 5
//            foregroundImageView.layer.shadowOpacity = 0.9
            
        }
    }
}

extension UIImage{
    
    //creates a UIImage given a UIColor
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}


// 여기부터 네트워크

import Foundation
struct APIConstants {
    static let baseURL = "https://asia-northeast3-library-of-millie.cloudfunctions.net/api"
    
    static let getBookInfoURL = baseURL + "/book"
}

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}

import Alamofire

struct UserSignService{
    static let shared = UserSignService()
        
    func readUserData(bookId: Int, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        let url = APIConstants.getBookInfoURL + "/\(bookId)"
        let header: HTTPHeaders = [
            "content-Type" : "application/json"
            ]
        
        let dataRequest = AF.request(url,
                                     method: .get,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        dataRequest.responseData { dataResponse in
            switch dataResponse.result{
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else {return}
                guard let value = dataResponse.value else {return}
                let networkResult = self.judgeGetInfoStatus(by: statusCode, value)
                completion(networkResult)
            case .failure(let err):
                print(err)
                completion(.networkFail)
            }
        }
    }
    
    private func judgeGetInfoStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode{
        case 200: return isValidInfoData(data: data)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    private func isValidInfoData(data: Data) -> NetworkResult<Any>{
        let decoder = JSONDecoder()
        guard let decodeData = try? decoder.decode(DetailResponseData.self, from: data)
        else {return .pathErr}
        return .success(decodeData)
    }
}

// MARK: - Welcome
struct DetailResponseData: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: DetailResultData?
}

// MARK: - DataClass
struct DetailResultData: Codable {
    let bookInfoList: BookInfoList
    let reviewList: [ReviewList]
}

// MARK: - BookInfoList
struct BookInfoList: Codable {
    let completePercent: Int
    let bookImg: String
    let bookName, author, userStorage: String
    let postCount: Int
    let bookInfoListDescription, category: String
    let reviewPoint: Int
    let postSize, createdAt, updatedAt: String
    let id: Int

    enum CodingKeys: String, CodingKey {
        case completePercent, bookImg, bookName, author, userStorage, postCount
        case bookInfoListDescription = "description"
        case category, reviewPoint, postSize, createdAt, updatedAt, id
    }
}

// MARK: - ReviewList
struct ReviewList: Codable {
    let id: Int
    let userImg: String?
    let nickname: String
    let createdAt, updatedAt: String?
    let contents: String
    let likeCount: Int
}

extension DetailVC {
    
    func getUserData() {
        UserSignService.shared.readUserData(bookId: 4) { responseData in
            switch responseData {
            case .success(let BookInfoResponse):
                guard let response = BookInfoResponse as?
                        DetailResponseData else {return}
                if let userData = response.data {
                    let completePercent = String(userData.bookInfoList.completePercent)
                    self.completePercentLabel.text = "완독할 확률 \(completePercent)%"
                    self.completePercentLabel.sizeToFit()
                    
                    
                    
                    let reviewCount = userData.reviewList.count
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
