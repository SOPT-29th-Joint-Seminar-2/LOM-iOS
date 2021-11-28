//
//  UISegmentedControl +.swift
//  LOM-iOS
//
//  Created by Junho Lee on 2021/11/28.
//

import UIKit

// MARK: radius 조절이 되는 segmentedcontrol
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
