//
//  TableViewCell.swift
//  AlbaReview
//
//  Created by 정지훈 on 2023/07/17.
//

import UIKit

import Then
import SnapKit

class ProfileCell: UITableViewCell {

    static let identifier = "ProfileCell"
    
    let profileImageView: UIImageView = UIImageView().then {
        $0.tintColor = .black
        $0.image = UIImage(systemName: "person.crop.circle")
    }
    
    let nicknameLabel: UILabel = UILabel().then {
        $0.configureLabel(text: "알바왕", fontSize: 30, color: .black)
    }
    
    let sexAgeLabel: UILabel = UILabel().then {
        $0.configureLabel(text: "남 / 23세", fontSize: 20, color: .systemGray2)
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
        [
            profileImageView,
            nicknameLabel,
            sexAgeLabel
        ]   .forEach { contentView.addSubview($0) }
    }
    
    private func setConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8)
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            make.width.height.equalTo(80)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
            make.top.equalTo(profileImageView.snp.top).offset(8)
        }
        
        sexAgeLabel.snp.makeConstraints { make in
            make.leading.equalTo(nicknameLabel.snp.leading).offset(2)
            make.top.equalTo(nicknameLabel.snp.bottom).offset(5)
        }
    }


}
