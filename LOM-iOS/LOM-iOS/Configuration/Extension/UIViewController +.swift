//
//  UIViewController +.swift
//  LOM-iOS
//
//  Created by Junho Lee on 2021/11/29.
//

import UIKit

extension UIViewController {
    func makeAlert(title: String,
                   message: String,
                   okAction : ((UIAlertAction) -> Void)? = nil,
                   completion : (() -> ())? = nil)
    {
        let alertViewController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: okAction)
        alertViewController.addAction(okAction)
        
        self.present(alertViewController, animated: true, completion: completion)
    }
}
