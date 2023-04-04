//
//  WriteReviewRatingViewController.swift
//  AlbaReview
//
//  Created by 정지훈 on 2023/04/04.
//

import UIKit

import Cosmos
import Then
import SnapKit
import RxCocoa
import RxSwift

class WriteReviewRatingViewController: UIViewController {
    
    let reviewTextView = UITextView(frame: .zero).then {
        $0.textColor = .lightGray
        $0.layer.borderColor = UIColor.systemGray2.cgColor
        $0.text = "이 알바에 대한 총평을 남겨주세요."
        $0.layer.cornerRadius = 5
        $0.layer.borderWidth = 1
    }
    
    let reviewCosmosView = CosmosView().then {
        $0.rating = 3.0
        $0.text = "3.0"
        $0.settings.textMargin = 10
        $0.settings.textFont = .systemFont(ofSize: 18)
        $0.settings.filledColor = .systemYellow
        $0.settings.starSize = 30
        $0.settings.starMargin = 5
        $0.settings.fillMode = .precise
    }
    
    let nextButton = UIButton().then {
        $0.isEnabled = false
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemGray2
        $0.setTitle("확인", for: .normal)
    }
    
    let viewModel = WriteReviewRatingViewModel()
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
        setUpNavigationBar("리뷰 작성", color: .white)
        view.backgroundColor = .white
    }
    
    private func setAddView() {
        [
            reviewTextView,
            reviewCosmosView,
            nextButton
        ]
            .forEach { view.addSubview($0) }
    }
    
    private func setConstraints() {
        reviewTextView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.height.equalTo(300)
        }
        
        reviewCosmosView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(reviewTextView.snp.bottom).offset(10)
        }
        
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
            make.bottom.equalToSuperview()
        }
        
    }
    
    private func bind() {
        
        //Input
        reviewCosmosView.rx.didTouchCosmos
            .onNext { rating in
                self.reviewCosmosView.text = String(format: "%.1f", rating)
            }
        
        reviewTextView.rx.didBeginEditing
            .bind(onNext: { _ in
                self.viewModel.didBeginEditingSubject.onNext(true)
            }).disposed(by: disposeBag)
        
        reviewTextView.rx.text
            .orEmpty
            .bind(to: viewModel.reviewTextSubject)
            .disposed(by: disposeBag)
        
        //Output
        viewModel.isEnableNextButton
            .bind(onNext: {
                self.updateEnableButton($0)
            }).disposed(by: disposeBag)
        
        viewModel.didBeginEditingSubject
            .filter { $0 }
            .bind(onNext: { _ in
                self.updateReviewTextViewUI()
            }).disposed(by: disposeBag)
    }

}

extension WriteReviewRatingViewController {
    
    func updateEnableButton(_ isEnable: Bool) {
        if isEnable {
            nextButton.isEnabled = true
            nextButton.backgroundColor = .systemCyan
        } else {
            nextButton.isEnabled = false
            nextButton.backgroundColor = .systemGray2
        }
    }
    
    func updateReviewTextViewUI() {
        self.reviewTextView.text = ""
        self.reviewTextView.textColor = .black
    }
}
