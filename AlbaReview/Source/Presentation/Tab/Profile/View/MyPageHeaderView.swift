//
//  CollectionReusableView.swift
//  AlbaReview
//
//  Created by 정지훈 on 2023/07/17.
//

import UIKit

import Then
import SnapKit

class MyPageHeaderView: UITableViewHeaderFooterView {
        
    static let identifier = "MypageHeaderView"
    
    //MARK: - Properties
    let headerLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 16)
    }
    
    override init(reuseIdentifier: String?) {
        super .init(reuseIdentifier: reuseIdentifier)
        
        setAddView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetUp
    private func setAddView() {
        contentView.addSubview(headerLabel)
    }
    
    private func setConstraints() {
        headerLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8)
            make.top.bottom.trailing.equalToSuperview()
        }
    }
}
