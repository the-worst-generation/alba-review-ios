//
//  AlabaExperienceVC.swift
//  AlbaReview
//
//  Created by 정지훈 on 2023/03/21.
//

import UIKit

import Then
import SnapKit
import RxCocoa
import RxSwift

class AlbaExperienceViewController: UIViewController {
    
    let plusButton = UIButton().then {
        $0.tintColor = .black
        $0.setImage(UIImage(systemName: "plus.circle"), for: .normal)
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
        setUpNavigationBar("알바 경력", color: .white)
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    private func setAddView() {
        
        [
         plusButton,
         nextButton].forEach { view.addSubview($0) }
        
    }
    
    
    private func setConstraints() {
        
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(80)
        }
        
        plusButton.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top).offset(-10)
            make.trailing.equalToSuperview().inset(10)
        }
        
    }
    
    private func bind() {
    }
    
    
}

