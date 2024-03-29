//
//  UITextField++.swift
//  AlbaReview
//
//  Created by 정지훈 on 2023/03/21.
//

import UIKit

extension UITextField {
    
    func setPlaceholder(color: UIColor) {
        guard let string = self.placeholder else {
            return
        }
        attributedPlaceholder = NSAttributedString(string: string, attributes: [.foregroundColor: color])
    }
    
    func addLeftPadding(_ width: CGFloat) {
        self.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: width, height: 0.0))
        self.leftViewMode = .always
    }
}
