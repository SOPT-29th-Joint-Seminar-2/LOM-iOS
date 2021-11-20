//
//  SeawaterHomeBannerTVC.swift
//  LOM-iOS
//
//  Created by 김혜수 on 2021/11/16.
//

import UIKit

class SeawaterHomeBannerTVC: UITableViewCell {
    
    public static let identifier = "SeawaterHomeBannerTVC"
    var bannerList: [Banner] = []

    @IBOutlet weak var bannerCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
        setCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUI() {
        self.backgroundColor = .clear
    }
    
    func setCollectionView() {
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        bannerCollectionView.backgroundColor = .clear
    }

}

extension SeawaterHomeBannerTVC: UICollectionViewDelegate {
    
}

extension SeawaterHomeBannerTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeawaterHomeBannerCVC.identifier, for: indexPath) as? SeawaterHomeBannerCVC else { return UICollectionViewCell() }
        cell.setData(title: bannerList[indexPath.row].title,
                     subtitle: bannerList[indexPath.row].subtitle,
                     image: bannerList[indexPath.row].image)
        return cell
    }
    
    
}

extension SeawaterHomeBannerTVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width,
                      height: UIScreen.main.bounds.width * (360/375))
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
