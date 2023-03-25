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
import Alamofire

class SearchPlaceViewController: UIViewController {
    
    let albaPlaceView = UIView().then {
        
        $0.backgroundColor = .white
        $0.layer.masksToBounds = false
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.5
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowRadius = 2
    }
    let albaPlaceTextField = UITextField().then {
        $0.placeholder = "장소 검색"
    }
    let placeSearchButton = UIButton().then {
        $0.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
    }
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        setUpUI()
        setAddView()
        setConstraints()
        
        bind()
    }
    
    //MARK: - SetUp
    private func setUpUI() {
        view.backgroundColor = .white
        setUpNavigationBar("", color: .white)
    }
    private func setAddView() {
    
        [
            albaPlaceTextField,
            placeSearchButton
        ]   .forEach { albaPlaceView.addSubview($0) }
        
        view.addSubview(albaPlaceView)
        
    }
    
    private func setConstraints() {
        
        albaPlaceView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.height.equalTo(40)
        }
        
        albaPlaceTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        placeSearchButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
        }
        
    }
    
    private func bind() {
        
    }
}
