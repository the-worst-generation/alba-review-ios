//
//  ChoiceYearViewController.swift
//  HMOA_iOS
//
//  Created by 정지훈 on 2023/02/24.
//

import UIKit

import SnapKit
import Then
import RxCocoa
import RxSwift

class ChoiceYearViewController: UIViewController {
    //MARK: - Property
    let xButton = UIButton().then {
        $0.setImage(UIImage(named: "x"), for: .normal)
    }
    
    let birthYearLabel = UILabel().then {
        $0.configureLabel(text: "출생 연도", fontSize: 16, color: .black)
    }
    
    let yearPicker = UIPickerView()
    
    let okButton = UIButton().then {
        $0.titleLabel?.font = .boldSystemFont(ofSize: 16)
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemCyan
    }
    
    let disposeBag = DisposeBag()
    let viewModel = ChoiceYearViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        setAddView()
        setConstraints()
        bind()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        yearPicker.subviews[1].backgroundColor = .clear
//        let frame = view.frame
//        let upLine = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: 1))
//        let underLine = UIView(frame: CGRect(x: 0, y: 40, width: frame.width, height: 1))
//
//        upLine.backgroundColor = .customColor(.gray2)
//        underLine.backgroundColor = .customColor(.gray2)
//
//        yearPicker.subviews[1].addSubview(upLine)
//        yearPicker.subviews[1].addSubview(underLine)
        
    }
    
    private func setUpUI() {
        view.backgroundColor = .white
    }
    
    private func setAddView() {
        [xButton, birthYearLabel, yearPicker, okButton].forEach { view.addSubview($0) }
    }
    
    private func setConstraints() {
        
        xButton.snp.makeConstraints { make in
            make.width.height.equalTo(12)
            make.top.equalToSuperview().inset(23)
            make.trailing.equalToSuperview().inset(22)
        }
        
        birthYearLabel.snp.makeConstraints { make in
            make.top.equalTo(xButton.snp.bottom).offset(17)
            make.leading.equalToSuperview().inset(38)
        }
        
        yearPicker.snp.makeConstraints { make in
            make.top.equalTo(birthYearLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        
        okButton.snp.makeConstraints { make in
            make.top.equalTo(yearPicker.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(24)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
    }
    
    private func bind() {
        
        viewModel.yearOb
            .bind(to: yearPicker.rx.itemTitles) { _, item in
                return "\(item)"
            }.disposed(by: disposeBag)
        
        xButton.rx.tap
            .subscribe(onNext: {
                self.dismiss(animated: true)
            }).disposed(by: disposeBag)
        
        okButton.rx.tap
            .subscribe(onNext: {
            self.dismiss(animated: true)
            }).disposed(by: disposeBag)
        
        yearPicker.rx.itemSelected
            .map { $0.row }
            .subscribe(onNext: { index in
                self.viewModel.selectedIndex.onNext(index)
            }).disposed(by: disposeBag)
    
    }
}

