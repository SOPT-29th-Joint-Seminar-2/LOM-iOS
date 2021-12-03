//
//  SeawaterDetailVC.swift
//  LOM-iOS
//
//  Created by 김혜수 on 2021/11/15.
//

import UIKit

struct review {
    let name: String
    let date: String
    let content: String
}

class SeawaterDetailVC: UIViewController {
    
    var bookId: Int = 0
    var completePercent: Int = 0
    var reviewList: [ReviewList] = []
    
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var reviewTableView: UITableView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookInfoLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var postCountLabel: UILabel!
    
    @IBOutlet weak var reviewTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var reviewContainerViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        setUI()
        getBookDetailNetworking(id: bookId)
    }
    
    func setUI() {
        let attributedStr = NSMutableAttributedString(string: percentLabel.text!)
        attributedStr.addAttribute(.foregroundColor, value: UIColor.milliePurple, range: (percentLabel.text! as NSString).range(of: "밀리픽"))
        percentLabel.attributedText = attributedStr
    }
    
    
    func setData() {
        percentLabel.text = "밀리픽 | 완독할 확률 \(completePercent)%"
    }
    
    func setTableView() {
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        reviewTableViewHeight.constant = CGFloat(120 * reviewList.count)
        reviewContainerViewHeight.constant = CGFloat(70 + (120*reviewList.count))
    }
    
}

extension SeawaterDetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension SeawaterDetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = reviewTableView.dequeueReusableCell(withIdentifier: SeawaterDetailReviewTVC.identifier, for: indexPath) as? SeawaterDetailReviewTVC else { return UITableViewCell() }
        cell.setData(name: reviewList[indexPath.row].nickname,
                     date: reviewList[indexPath.row].createdAt ?? "",
                     content: reviewList[indexPath.row].contents)
        return cell
    }
    
}

extension SeawaterDetailVC {
    func getBookDetailNetworking(id: Int) {
        SeawaterBookService.shared.getBookInfo(bookId: bookId) { res in
            switch res {
            case .success(let data):
                guard let data = data as? DetailResponseData else { return }
                self.titleLabel.text = data.data?.bookInfoList.bookName
                self.authorLabel.text = data.data?.bookInfoList.author
                guard let url = URL(string: data.data?.bookInfoList.bookImg ?? "") else {
                    return
                }
                let imageURL = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.bookImageView.image = UIImage(data: imageURL!)
                }
                self.bookInfoLabel.text = data.data?.bookInfoList.bookInfoListDescription
                self.reviewCountLabel.text = "\(data.data?.reviewList.count ?? 0)개"
                self.postCountLabel.text = "\(data.data?.bookInfoList.postCount ?? 0)개"
                self.reviewList = data.data?.reviewList ?? []
                self.setTableView()
                
            case .pathErr: print("pathErr")
            case .requestErr(_): print("requestErr")
            case .serverErr: print("serverErr")
            case .networkFail: print("networkFail")
            }
        }
    }
    
}
