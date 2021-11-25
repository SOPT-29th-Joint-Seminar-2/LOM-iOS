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
    
    var completePercent: Int = 0
    var reviewList: [review] = []
    
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var reviewTableView: UITableView!
    
    @IBOutlet weak var reviewTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var reviewContainerViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDummy()
        setData()
        setUI()
        setTableView()
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
        return cell
    }
    
}

extension SeawaterDetailVC {
    func setDummy() {
        reviewList.append(contentsOf: [review(name: "아요짱", date: "2021.11.11", content: "페니가 성장한 만큼, 저도 성장한 기분이었습니다."),
                                       review(name: "아요짱", date: "2021.11.11", content: "페니가 성장한 만큼, 저도 성장한 기분이었습니다."),
                                       review(name: "아요짱", date: "2021.11.11", content: "페니가 성장한 만큼, 저도 성장한 기분이었습니다."),
                                       review(name: "아요짱", date: "2021.11.11", content: "페니가 성장한 만큼, 저도 성장한 기분이었습니다."),
                                       review(name: "아요짱", date: "2021.11.11", content: "페니가 성장한 만큼, 저도 성장한 기분이었습니다.")])
    }
}
