//
//  SeawaterHome.swift
//  LOM-iOS
//
//  Created by 김혜수 on 2021/11/15.
//

import UIKit

struct Banner {
    let title: String
    let subtitle: String
    let image: UIImage
}

struct Book {
    let title: String
    let writer: String
    let image: UIImage
}

class SeawaterHomeVC: UIViewController {
    
    var bannerList: [Banner] = []
    var bestBookList: [Book] = []
    
    @IBOutlet weak var statusBgView: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var statusBgViewHeight: NSLayoutConstraint!
    
    // MARK: - View Controller LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDummy()
        setUI()
        setTableVIew()
    }
    
    func setUI() {
        statusBgView.translatesAutoresizingMaskIntoConstraints = false
        statusBgView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        statusBgView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        statusBgView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        statusBgView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 0).isActive = true
    }
    
    // MARK: - set TableView, CollectionView
    func setTableVIew() {
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.backgroundColor = .clear
        if #available(iOS 15, *) {
            homeTableView.sectionHeaderTopPadding = 0
        }
    }
}

// MARK: - TableView Extension
extension SeawaterHomeVC: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if homeTableView.contentOffset.y > -20 {
            UIView.animate(withDuration: 0.2) {
                self.navigationView.backgroundColor = .white
                self.statusBgView.backgroundColor = .white
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                self.navigationView.backgroundColor = .clear
                self.statusBgView.backgroundColor = .clear
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return UIScreen.main.bounds.width * (360/375)
        case 1, 3: return 50
        case 2: return 475
        case 4...13: return 109
        default: return 100
        }
    }
}

extension SeawaterHomeVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // 상단 네비게이션
        navigationView.backgroundColor = .clear
        return navigationView
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 14
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SeawaterHomeBannerTVC.identifier, for: indexPath) as? SeawaterHomeBannerTVC else { return UITableViewCell() }
            cell.bannerList = bannerList
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SeawaterHomeTitleTVC.identifier, for: indexPath) as? SeawaterHomeTitleTVC else { return UITableViewCell() }
            cell.setData(title: "오늘의 책")
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SeawaterHomeTodayBookTVC.identifier, for: indexPath) as? SeawaterHomeTodayBookTVC else { return UITableViewCell() }
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SeawaterHomeTitleTVC.identifier, for: indexPath) as? SeawaterHomeTitleTVC else { return UITableViewCell() }
            cell.setData(title: "서점 베스트 TOP 10")
            return cell
        case 4...13:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SeawaterHomeBestTVC.identifier, for: indexPath) as? SeawaterHomeBestTVC else { return UITableViewCell() }
            cell.setData(rank: indexPath.row - 3,
                         image: bestBookList[indexPath.row - 4].image,
                         title: bestBookList[indexPath.row - 4].title,
                         writer: bestBookList[indexPath.row - 4].writer)
            return cell
        default:
            return UITableViewCell()
        }
        
        
    }
    
    
}

// MARK: - Dummy Data Setting
extension SeawaterHomeVC {
    func setDummy() {
        bannerList.append(contentsOf: [Banner(title: "SNS로 ‘진짜 나’를\n찾을 수 있을까",
                                              subtitle: "종이책 출간 전에 읽는 화제의 신작",
                                              image: Const.Image.bannerImg1),
                                       Banner(title: "SNS로 ‘진짜 나’를\n찾을 수 있을까",
                                              subtitle: "종이책 출간 전에 읽는 화제의 신작",
                                              image: Const.Image.bannerImg2),
                                       Banner(title: "SNS로 ‘진짜 나’를\n찾을 수 있을까",
                                              subtitle: "종이책 출간 전에 읽는 화제의 신작",
                                              image: Const.Image.bannerImg3)])
        
        bestBookList.append(contentsOf: [Book(title: "거꾸로 읽는 세계",
                                              writer: "유시민",
                                              image: Const.Image.bestImg1),
                                         Book(title: "달러구트 꿈 백화점 2",
                                              writer: "이미예(지은이)",
                                              image: Const.Image.bestImg2),
                                         Book(title: "달러구트 꿈 백화점",
                                              writer: "이미예(지은이)",
                                              image: Const.Image.bestImg3),
                                         Book(title: "거꾸로 읽는 세계",
                                              writer: "유시민",
                                              image: Const.Image.bestImg4),
                                         Book(title: "거꾸로 읽는 세계",
                                              writer: "유시민",
                                              image: Const.Image.bestImg1),
                                         Book(title: "거꾸로 읽는 세계",
                                              writer: "유시민",
                                              image: Const.Image.bestImg1),
                                         Book(title: "거꾸로 읽는 세계",
                                              writer: "유시민",
                                              image: Const.Image.bestImg1),
                                         Book(title: "거꾸로 읽는 세계",
                                              writer: "유시민",
                                              image: Const.Image.bestImg1),
                                         Book(title: "거꾸로 읽는 세계",
                                              writer: "유시민",
                                              image: Const.Image.bestImg1),
                                         Book(title: "거꾸로 읽는 세계",
                                              writer: "유시민",
                                              image: Const.Image.bestImg1)
                                        ])
    }
}
