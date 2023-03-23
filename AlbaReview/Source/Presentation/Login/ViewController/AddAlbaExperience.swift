//
//  AddAlbaExperience.swift
//  AlbaReview
//
//  Created by 정지훈 on 2023/03/23.
//

import UIKit

import Then
import SnapKit
import RxCocoa
import RxSwift
import DropDown

class AddAlbaExperienceViewController: UIViewController {
    
    //MARK: - Property
    let explainLabel = UILabel().then {
        $0.numberOfLines = 2
        $0.configureLabel(text:
"""
알바했던 지점과
기간을 알려주세요
""",
                          fontSize: 30,
                          color: .black)
    }
    
    let albaPlaceView = UIView()
    let albaPlaceLabel = UILabel().then {
        $0.text = "알바 지점"
    }
    let placeSearchButton = UIButton().then {
        $0.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
    }
    
    let periodDropView = UIView()
    let periodLabel = UILabel().then {
        $0.text = "알바 기간"
    }
    let periodButton = UIButton().then {
        $0.setImage(UIImage(named: "downPolygon"), for: .normal)
    }
    
    let addButton = UIButton().then {
        $0.isEnabled = false
        $0.titleLabel?.font = .boldSystemFont(ofSize: 20)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemGray2
        $0.setTitle("추가하기", for: .normal)
    }
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super .viewDidLoad()
        setUpUI()
        setAddView()
        setConstraints()
    }
    
    
    override func viewDidLayoutSubviews() {
        super .viewDidLayoutSubviews()

    //TODO: - 그림자 넣기
        [
            albaPlaceView,
            periodDropView
        ]   .forEach {
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 10
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOpacity = 0.25
            $0.layer.shadowOffset = CGSize(width: 0, height: 2)
            $0.layer.shadowRadius = 2
        }
    }
    
    
    //MARK: - SetUp
    private func setUpUI() {
        view.backgroundColor = .white
        setUpNavigationBar("", color: .white)
    }
    private func setAddView() {
    
        [
            albaPlaceLabel,
            placeSearchButton
        ]   .forEach { albaPlaceView.addSubview($0) }
        
        [
            periodLabel,
            periodButton
        ]   .forEach { periodDropView.addSubview($0) }
    
        [
            explainLabel,
            albaPlaceView,
            periodDropView,
            addButton
        ]   .forEach { view.addSubview($0) }
        
    }
    
    private func setConstraints() {
        
        explainLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.leading.trailing.equalToSuperview().inset(17)
        }
        
        albaPlaceView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(explainLabel.snp.bottom).offset(30)
            make.width.equalTo(300)
            make.height.equalTo(30)
        }
        
        albaPlaceLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        placeSearchButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
        }
        
        periodDropView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(albaPlaceView.snp.bottom).offset(30)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        
        periodLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        periodButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
        }
        
        addButton.snp.makeConstraints { make in
            make.height.equalTo(80)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
