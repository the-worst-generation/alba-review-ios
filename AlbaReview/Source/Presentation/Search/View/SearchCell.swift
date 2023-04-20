//
//  SearchCell.swift
//  AlbaReview
//
//  Created by 정지훈 on 2023/03/30.
//

import UIKit

import Then
import SnapKit
import RxCocoa
import RxSwift

class SearchCell: UITableViewCell {
    
    static let identifier = "SearchCell"
    
    let nameLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 18)
    }
    
    let addressLabel = UILabel().then {
        $0.configureLabel(text: "", fontSize: 12, color: .black)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpUI()
        setAddView()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetUp
    private func setUpUI() {
        contentView.backgroundColor = .white
    }
    
    private func setAddView() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(addressLabel)
    }
    
    private func setConstraints() {
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(5)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
        }
    }
}

extension SearchCell {
    func configure(data: Document) {
        nameLabel.text = data.placeName
        addressLabel.text = data.addressName
    }
}
