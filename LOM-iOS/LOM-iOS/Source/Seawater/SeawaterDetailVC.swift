//
//  SeawaterDetailVC.swift
//  LOM-iOS
//
//  Created by 김혜수 on 2021/11/15.
//

import UIKit

class SeawaterDetailVC: UIViewController {
    
    var completePercent: Int = 0

    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        setUI()
        
    }
    
    func setUI() {
        
//        outerView.layer.cornerRadius = outerView.bounds.height / 2
//        outerView.layer.borderColor = UIColor.blue.cgColor
//        outerView.layer.borderWidth = 1
        
        
        let attributedStr = NSMutableAttributedString(string: percentLabel.text!)

        /// text의 range 중에서 "Bonus"라는 글자는 UIColor를 blue로 변경
        attributedStr.addAttribute(.foregroundColor, value: UIColor.milliePurple, range: (percentLabel.text! as NSString).range(of: "밀리픽"))

        percentLabel.attributedText = attributedStr
        
        
    }
    
   
    
    func setData() {
        percentLabel.text = "밀리픽 | 완독할 확률 \(completePercent)%"
        
    }

}
