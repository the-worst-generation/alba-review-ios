//
//  UIViewController++.swift
//  AlbaReview
//
//  Created by 정지훈 on 2023/03/21.
//

import UIKit

extension UIViewController {
    
    func setBottomBorder(sender: UIView, width: CGFloat, height: CGFloat, color: UIColor) {
        
        let border = CALayer()
        border.frame = CGRect(x: 0, y: height -  1, width: width, height: 1)
        border.borderColor = color.cgColor
        border.borderWidth = 1
        
        sender.layer.addSublayer(border)
        sender.layer.masksToBounds = true
    }
    
}
