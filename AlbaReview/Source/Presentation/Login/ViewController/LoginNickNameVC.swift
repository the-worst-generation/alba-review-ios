//
//  LoginNickNameVC.swift
//  AlbaReview
//
//  Created by 정지훈 on 2023/03/21.
//

import UIKit

import Then
import SnapKit
import RxSwift
import RxCocoa

class LoginNickNameViewController: UIViewController {
    //MARK: - Property
    let welcomeLabel = UILabel().then {
        $0.configureLabel(text: "알바 리뷰에 오신 걸 환영합니다🥳", fontSize: 14, color: .black)
    }
    
    let userInfoLabel = UILabel().then {
        $0.numberOfLines = 2
        $0.configureLabel(text:
"""
알바 리뷰에서 사용할
닉네임을 알려주세요
""",
                          fontSize: 30,
                          color: .black)
    }
    
    let nicknameTextField = UITextField().then {
        $0.placeholder = "닉네임"
        $0.setPlaceholder(color: .systemGray2)
        $0.addLeftPadding(14)
    }
    
    
    let middleView = UIView()
    let succesImageView = UIImageView().then {
        $0.isHidden = true
        $0.image = UIImage(systemName: "checkmark")
    }
    
    let duplicateButton = UIButton().then {
        $0.titleLabel?.font = .systemFont(ofSize: 16)
        $0.setTitleColor(.black, for: .normal)
        $0.setTitle("중복확인", for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.layer.borderColor = UIColor.black.cgColor
    }
    
    let nextButton = UIButton().then {
        $0.titleLabel?.font = .boldSystemFont(ofSize: 20)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemCyan
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
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        setUpNavigationBar("1/3", color: .white)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: - SetUp
    private func setUpUI() {
        view.backgroundColor = .white
    }
    private func setAddView() {
        
        [nicknameTextField,
         succesImageView].forEach { middleView.addSubview($0) }
        
        [welcomeLabel,
         userInfoLabel,
         duplicateButton,
         middleView,
         nextButton].forEach { view.addSubview($0) }
        
    }
    
    override func viewDidLayoutSubviews() {
        super .viewDidLayoutSubviews()
        
        setBottomBorder(sender: middleView,
                        width: middleView.frame.width,
                        height: middleView.frame.height,
                        color: .black)
    }
    
    private func setConstraints() {
        welcomeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(17)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(120)
        }
        
        userInfoLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(17)
            make.top.equalTo(welcomeLabel.snp.bottom).offset(10)
        }
        
        duplicateButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(17)
            make.centerY.equalToSuperview()
            make.width.equalTo(70)
        }
        
        middleView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(17)
            make.trailing.equalTo(duplicateButton.snp.leading).offset(-20)
            make.centerY.equalToSuperview()
            make.height.equalTo(40)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.trailing.equalTo(succesImageView.snp.leading)
        }
        
        succesImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
        }
        
        
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(80)
        }
    }
    
    private func bind() {
        nextButton.rx.tap
            .bind(onNext: {
                self.navigationController?.pushViewController(LoginAgeSexViewController(), animated: true)
            }).disposed(by: disposeBag)
    }
    
    
    
}
