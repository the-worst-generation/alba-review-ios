//
//  TableViewCell.swift
//  AlbaReview
//
//  Created by 정지훈 on 2023/07/17.
//

import UIKit

import Then
import SnapKit

class OtherCell: UITableViewCell {

    static let identifier = "OtherCell"
    
    let titleLabel = UILabel().then {
        $0.configureLabel(text: "", fontSize: 16, color: .black)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpUI()
        setAddView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetUp
    private func setUpUI() {
        
    }
    
    private func setAddView() {
        addSubview(titleLabel)
    }
    
    private func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.bottom.trailing.equalToSuperview()
        }
    }


}
