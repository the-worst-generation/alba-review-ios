//
//  WritableReviewCell.swift
//  AlbaReview
//
//  Created by 정지훈 on 2023/04/02.
//

import UIKit

import TagListView
import Cosmos

class WritableReviewCell: UICollectionViewCell {
    
    static let identifier = "WritableReviewCell"
    
    let nameLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 16)
    }
    
    lazy var taglistView = TagListView().then {
        $0.borderWidth = 1
        $0.paddingY = 4
        $0.paddingX = 12
        $0.tagBackgroundColor = .white
        $0.cornerRadius = 10
        $0.textColor = .black
        $0.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: 20)
        $0.addTags(["테스트", "테스테스테스테스트"])
        $0.alignment = .leading
    }
    
    let reviewCountLabel = UILabel().then {
        $0.configureLabel(text: "", fontSize: 10, color: .black)
    }
    
    let reviewCosmos = CosmosView().then {
        $0.settings.textFont = .systemFont(ofSize: 10)
        $0.settings.fillMode = .precise
        $0.settings.starMargin = 3
        $0.settings.starSize = 10
    }
    
    let goodImageView = UIImageView().then {
        $0.tintColor = .systemRed
        $0.image = UIImage(systemName: "hand.thumbsup")
    }
    
    let badImageView = UIImageView().then {
        $0.tintColor = .systemBlue
        $0.image = UIImage(systemName: "hand.thumbsdown")
    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        setUpUI()
        setAddView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetUp
    private func setUpUI() {
        backgroundColor = .white
        self.layer.addBorder([.bottom], color: .black, width: 1)
    }
    private func setAddView() {
        [
            nameLabel,
            taglistView,
            reviewCountLabel,
            reviewCosmos,
            goodImageView,
            badImageView
        ].forEach { contentView.addSubview($0) }
    }
    
    private func setConstraints() {
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }
        
        taglistView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(16)
        }
        
        reviewCountLabel.snp.makeConstraints { make in
            make.top.equalTo(taglistView.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(16)
        }
        
        reviewCosmos.snp.makeConstraints { make in
            make.top.equalTo(reviewCountLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(16)
        }
        
        badImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(10)
        }
        
        goodImageView.snp.makeConstraints { make in
            make.trailing.equalTo(badImageView.snp.leading).offset(-8)
            make.bottom.equalToSuperview().inset(10)
        }
    }

}

extension WritableReviewCell {
    
    func configure(_ data: WritableReviewData) {
        nameLabel.text = data.name
        reviewCosmos.rating = data.rating
        reviewCosmos.text = "(\(data.rating))"
        reviewCountLabel.text = " 리뷰 개수 \(data.reviewCount)"
    }
}
