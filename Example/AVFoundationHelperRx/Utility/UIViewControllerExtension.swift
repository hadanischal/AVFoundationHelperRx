//
//  UIViewControllerExtension.swift
//  AVFoundationHelperRx_Example
//
//  Created by Nischal Hada on 6/12/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlertView(withTitle title: String?, andMessage message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) -> Void in
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
