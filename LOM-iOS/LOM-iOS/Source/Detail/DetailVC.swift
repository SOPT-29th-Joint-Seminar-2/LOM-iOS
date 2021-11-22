//
//  DetailVC.swift
//  LOM-iOS
//
//  Created by 김혜수 on 2021/11/13.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var detailReviewTV: UITableView!
    @IBOutlet weak var detailSC: UISegmentedControl!
    @IBOutlet weak var reviewPostButton: UIButton!
    @IBOutlet weak var reviewContentView: UIView!
    
    var detailTVContentList: [detailReviewTVData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBasicLayout()
        registerXib()
        detailReviewTV.delegate = self
        detailReviewTV.dataSource = self
        initItemTVContentList()
    }
    
    func setBasicLayout() {
        self.detailSC.layer.cornerRadius = 20.5
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
