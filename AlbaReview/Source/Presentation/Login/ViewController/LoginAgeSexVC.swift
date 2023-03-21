//
//  LoginAgeSexVC.swift
//  AlbaReview
//
//  Created by 정지훈 on 2023/03/21.
//

import Foundation


import UIKit

import Then
import SnapKit
import RxCocoa
import RxSwift

class LoginAgeSexViewController: UIViewController {
    //MARK: - Property
    let explainLabel = UILabel().then {
        $0.numberOfLines = 2
        $0.configureLabel(text:
"""
나이와 성별을
알려주세요
""",
                          fontSize: 30,
                          color: .black)
    }
    let birthYearLabel = UILabel().then {
        $0.configureLabel(text: "출생연도", fontSize: 16, color: .black)
    }
    
    let selectYearView = UIView()
    let selectLabel = UILabel().then {
        $0.configureLabel(text: "선택", fontSize: 16, color: .systemGray3)
    }
    let selectYearButton = UIButton().then {
        $0.setImage(UIImage(named: "downPolygon"), for: .normal)
    }
    
    let sexStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 16
    }
    
    let nextButton = UIButton().then {
        $0.isEnabled = false
        $0.titleLabel?.font = .boldSystemFont(ofSize: 20)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemGray2
        $0.setTitle("다음", for: .normal)
    }
    
    var womanButton: UIButton!
    var manButton: UIButton!
    
    let viewModel = StartViewModel()
    let disposeBag = DisposeBag()

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar("2/3", color: .black)
        setUpUI()
        setAddView()
        setUpConstraints()
        
        bind()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let frame = selectYearView.frame
        setBottomBorder(sender: selectYearView, width: frame.width, height: frame.height, color: .black)
    }
    
    //MARK: - SetUp
    private func setUpUI() {
        view.backgroundColor = .white
        
        womanButton = UIButton(configuration: configureButton("여성"))
        manButton = UIButton(configuration: configureButton("남성"))
        womanButton.setImage(UIImage(named: "circle"), for: .normal)
        womanButton.setImage(UIImage(named: "selectCircle"), for: .selected)
        manButton.setImage(UIImage(named: "selectCircle"), for: .selected)
        manButton.setImage(UIImage(named: "circle"), for: .normal)
    }
    
    private func configureButton(_ title: String) -> UIButton.Configuration {
        var config = UIButton.Configuration.plain()
        
        var titleAttr = AttributedString.init(title)
        titleAttr.font = UIFont.systemFont(ofSize: 16)
        titleAttr.foregroundColor = .black
        
        config.baseBackgroundColor = .white
        config.imagePadding = 12
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        config.attributedTitle = titleAttr
        
        return config
    }
    
    private func setAddView() {
        [selectLabel, selectYearButton].forEach { selectYearView.addSubview($0) }
        
        [womanButton, manButton].forEach { sexStackView.addArrangedSubview($0) }
        
        [explainLabel, birthYearLabel, selectYearView, sexStackView, nextButton].forEach { view.addSubview($0) }
    }
    
    private func setUpConstraints() {
        
        explainLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.leading.trailing.equalToSuperview().inset(17)
        }
        
        birthYearLabel.snp.makeConstraints { make in
            make.top.equalTo(explainLabel.snp.bottom).offset(34)
            make.leading.equalToSuperview().inset(17)
        }
        
        selectLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(17)
            make.centerY.equalToSuperview()
        }
        
        selectYearButton.snp.makeConstraints { make in
            make.leading.equalTo(selectLabel.snp.trailing)
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        selectYearView.snp.makeConstraints { make in
            make.top.equalTo(birthYearLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(17)
            make.width.equalTo(152)
            make.height.equalTo(46)
        }
        
        sexStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(17)
            make.top.equalTo(selectYearView.snp.bottom).offset(38)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(80)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    //MARK: - Bind
    private func bind() {
        
        //연도 선택 터치 이벤트
        selectYearButton.rx.tap
            .subscribe(onNext: {
                let vc = self.viewModel.presentSelectYear()
                self.present(vc, animated: true)
                self.updateYearLabel(vc)
            }).disposed(by: disposeBag)
        
        //여성 버튼 터치 이벤트
        womanButton.rx.tap
            .bind(onNext: {
                self.viewModel.womanButtonOb.onNext(true)
                self.viewModel.manButtonOb.onNext(false)
            }).disposed(by: disposeBag)
            
        //남성 버튼 터치 이벤트
        manButton.rx.tap
            .bind(onNext: {
                self.viewModel.womanButtonOb.onNext(false)
                self.viewModel.manButtonOb.onNext(true)
            }).disposed(by: disposeBag)
        
        viewModel.manButtonOb
            .bind(to: self.manButton.rx.isSelected)
            .disposed(by: disposeBag)
        
        viewModel.womanButtonOb
            .bind(to: self.womanButton.rx.isSelected)
            .disposed(by: disposeBag)
        
        viewModel.isComplete
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { result in
                self.updateNextButton(result)
            }).disposed(by: disposeBag)
        
        //시작 버튼 터치 이벤트
        nextButton.rx.tap
            .bind(onNext: {
                self.navigationController?.pushViewController(AlabaExperiecnceCheckViewController(), animated: true)
            }).disposed(by: disposeBag)
    }

    
    
    //MARK: - UpdateUI
    func updateYearLabel(_ vc: ChoiceYearViewController) {
       vc.viewModel.selectedIndex
            .map { vc.viewModel.years[$0] }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { year in
                self.viewModel.yearTextOb.onNext("selected")
                self.selectLabel.text = "\(year)"
                self.selectLabel.textColor = .black
            }).disposed(by: disposeBag)
    }
    
    func updateNextButton(_ result: Bool) {
        if result {
            nextButton.backgroundColor = .systemMint
            nextButton.isEnabled = result
        }
        else {
            nextButton.backgroundColor = .systemGray2
            nextButton.isEnabled = result
        }
    }
}
