//
//  SeawaterHome.swift
//  LOM-iOS
//
//  Created by κΉνμ on 2021/11/15.
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
    var bestBookList: [BestResultData] = []
    
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
        getBestBookNetworking()
    }
    
    func setUI() {
        setNavigationBarUI()
        statusBgView.translatesAutoresizingMaskIntoConstraints = false
        statusBgView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        statusBgView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        statusBgView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        statusBgView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 0).isActive = true
    }
    
    func setNavigationBarUI() {
        self.navigationController?.navigationBar.isHidden = true
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row >= 4, indexPath.row <= 13 {
            guard let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "SeawaterDetailVC") as? SeawaterDetailVC else { return }
            detailVC.bookId = bestBookList[indexPath.row - 4].bookID
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return UIScreen.main.bounds.width * (360/375)
        case 1, 3: return 50
        case 2: return 475
        case 4...(3 + bestBookList.count): return 109
        default: return 100
        }
    }
}

extension SeawaterHomeVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // μλ¨ λ€λΉκ²μ΄μ
        navigationView.backgroundColor = .clear
        return navigationView
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4+bestBookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SeawaterHomeBannerTVC.identifier, for: indexPath) as? SeawaterHomeBannerTVC else { return UITableViewCell() }
            cell.bannerList = bannerList
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SeawaterHomeTitleTVC.identifier, for: indexPath) as? SeawaterHomeTitleTVC else { return UITableViewCell() }
            cell.setData(title: "μ€λμ μ±")
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SeawaterHomeTodayBookTVC.identifier, for: indexPath) as? SeawaterHomeTodayBookTVC else { return UITableViewCell() }
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SeawaterHomeTitleTVC.identifier, for: indexPath) as? SeawaterHomeTitleTVC else { return UITableViewCell() }
            cell.setData(title: "μμ  λ² μ€νΈ TOP 10")
            return cell
        case 4...(3 + bestBookList.count):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SeawaterHomeBestTVC.identifier, for: indexPath) as? SeawaterHomeBestTVC else { return UITableViewCell() }
            cell.setData(rank: indexPath.row - 3,
                         image: bestBookList[indexPath.row - 4].bookImg,
                         title: bestBookList[indexPath.row - 4].bookName,
                         writer: bestBookList[indexPath.row - 4].author)
            return cell
        default:
            return UITableViewCell()
        }
        
        
    }
    
    
}

// MARK: - Dummy Data Setting
extension SeawaterHomeVC {
    
    func getBestBookNetworking() {
        SeawaterBookService.shared.getbestbook { res in
            switch res {
            case .success(let data):
                guard let data = data as? BestResponseData else { return }
                self.bestBookList = data.data ?? []
                self.setTableVIew()
            case .pathErr: print("pathErr")
            case .requestErr(_): print("requestErr")
            case .serverErr: print("serverErr")
            case .networkFail: print("networkFail")
            }
        }
    }
    
    func setDummy() {
        bannerList.append(contentsOf: [Banner(title: "SNSλ‘ βμ§μ§ λβλ₯Ό\nμ°Ύμ μ μμκΉ",
                                              subtitle: "μ’μ΄μ± μΆκ° μ μ μ½λ νμ μ μ μ",
                                              image: Const.Image.bannerImg1),
                                       Banner(title: "SNSλ‘ βμ§μ§ λβλ₯Ό\nμ°Ύμ μ μμκΉ",
                                              subtitle: "μ’μ΄μ± μΆκ° μ μ μ½λ νμ μ μ μ",
                                              image: Const.Image.bannerImg2),
                                       Banner(title: "SNSλ‘ βμ§μ§ λβλ₯Ό\nμ°Ύμ μ μμκΉ",
                                              subtitle: "μ’μ΄μ± μΆκ° μ μ μ½λ νμ μ μ μ",
                                              image: Const.Image.bannerImg3)])

    }
}
