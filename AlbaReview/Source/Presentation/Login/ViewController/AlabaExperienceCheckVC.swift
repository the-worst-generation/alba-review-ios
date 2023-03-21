//
//  AlabaExperienceCheckVC.swift
//  AlbaReview
//
//  Created by 정지훈 on 2023/03/21.
//

import UIKit

import Then
import SnapKit
import RxSwift
import RxCocoa

class AlabaExperiecnceCheckViewController: UIViewController{
    
    //MARK: - Property
    let explainLabel = UILabel().then {
        $0.numberOfLines = 2
        $0.configureLabel(text: "알바를 해보신 경험이 있나요?",
                          fontSize: 30,
                          color: .black)
    }
    let buttonStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.spacing = 30
        $0.axis = .horizontal
    }
    
    let yesButton = UIButton().then {
        $0.tintColor = .black
        $0.setImage(UIImage(systemName: "circle"), for: .normal)
    }
    let noButton = UIButton().then {
        $0.tintColor = .black
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
    }
    
    let nextButton = UIButton().then {
        $0.titleLabel?.font = .boldSystemFont(ofSize: 20)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemMint
        $0.setTitle("다음", for: .normal)
    }
    
    let disposeBag = DisposeBag()
    
    //MARK: - LifeCycle
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
        setUpNavigationBar("3/3", color: .white)
    }
    private func setAddView() {
        
        [yesButton,
         noButton].forEach { buttonStackView.addArrangedSubview($0) }
        
        [explainLabel,
         buttonStackView,
         nextButton].forEach { view.addSubview($0) }
        
    }
    
    
    private func setConstraints() {
        
        explainLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(17)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(120)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(50)
        }
        
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(80)
        }
    }
    
    private func bind() {
        yesButton.rx.tap
            .bind(onNext: {
                self.navigationController?.pushViewController(AlbaExperienceViewController(), animated: true)
            }).disposed(by: disposeBag)
    }
    
    
}
