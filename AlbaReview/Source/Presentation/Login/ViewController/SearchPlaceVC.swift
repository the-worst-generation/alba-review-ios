//
//  SearchPlaceViewController.swift
//  AlbaReview
//
//  Created by 정지훈 on 2023/03/23.
//

import UIKit

import Then
import SnapKit
import RxCocoa
import RxSwift

class SearchPlaceViewController: UIViewController {
    
    let albaPlaceView = UIView()
    let albaPlaceLabel = UILabel().then {
        $0.text = "알바 지점"
    }
    let placeSearchButton = UIButton().then {
        $0.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
    }
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        setUpUI()
        setAddView()
        setConstraints()
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
        
        view.addSubview(albaPlaceView)
        
    }
    
    private func setConstraints() {
        
        albaPlaceView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
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
        
    }
}
