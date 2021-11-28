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

    public var reviewTransfer = -1
    
    var detailTVContentList: [detailReviewTVData] = []{
        didSet{
            NotificationCenter.default.post(name: NSNotification.Name("TestNotification"), object: nil, userInfo: nil)
        }
    }
    func call(){
        NotificationCenter.default.addObserver(self, selector: #selector(dataRecieved), name: NSNotification.Name("TestNotification"), object:nil)
    }
    
    @objc func dataRecieved(notification: NSNotification){
        if detailTVContentList.count == reviewTransfer {
            self.detailReviewTV.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBasicLayout()
        registerXib()
        detailReviewTV.delegate = self
        detailReviewTV.dataSource = self
        setSegmentedControl()
        call()
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
