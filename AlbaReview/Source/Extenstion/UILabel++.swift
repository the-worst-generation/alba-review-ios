//
//  UILabel++.swift
//  AlbaReview
//
//  Created by 정지훈 on 2023/03/21.
//

import UIKit

extension UILabel {
    func configureLabel(text: String, fontSize: CGFloat, color: UIColor) {
        self.text = text
        self.font = .systemFont(ofSize: fontSize)
        self.textColor = color
    }
}
