//
//  WriteReviewViewController.swift
//  AlbaReview
//
//  Created by 정지훈 on 2023/04/04.
//

import UIKit

import Then
import SnapKit
import RxCocoa
import RxSwift
import TagListView

class WriteReviewViewController: UIViewController {
    
    //MARK: - Property
    let questionLabel = UILabel().then {
        $0.configureLabel(text: "사장님은 어떤 분이야?", fontSize: 30, color: .black)
    }
    
    lazy var tagListView = TagListView(frame: CGRect(x: 0,
                                                y: 0,
                                                width: view.frame.width,
                                                height: view.frame.height)).then {
    
        $0.tagSelectedBackgroundColor = .systemCyan
        $0.selectedTextColor = .white
        $0.marginX = 10
        $0.marginY = 20
        $0.borderColor = .systemGray2
        $0.tagBackgroundColor = .white
        $0.textFont = .systemFont(ofSize: 16)
        $0.textColor = .black
        $0.paddingY = 10
        $0.paddingX = 12
        $0.alignment = .leading
        $0.borderWidth = 1
        $0.cornerRadius = 10
        $0.addTags(["😊착해",
                    "🔥화가 많아",
                    "🌸먹을거 잘 사줘",
                    "🌼화를 잘 안내",
                    "😘뽀뽀 해드리고 싶어",
                    "👀cctv를 자주 봐",
                    "📝깐깐해",
                    "😊착해",
                    "🔥화가 많아",
                    "🌸먹을거 잘 사줘",
                    "🌼화를 잘 안내",
                    "😘뽀뽀 해드리고 싶어",
                    "👀cctv를 자주 봐",
                    "📝깐깐해",
                    "👻장난을 많이 쳐"])
    }
    
    let nextButton = UIButton().then {
        $0.isEnabled = false
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemGray2
        $0.setTitle("다음", for: .normal)
        
    }
    
    let disposeBag = DisposeBag()
    let viewModel = WriteReviewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setAddView()
        setConstraints()
        bind()
    }
    //MARK: - SetUp
    private func setUpUI() {
        view.backgroundColor = .white
        setUpNavigationBar("리뷰 작성", color: .black)
    }
    
    private func setAddView() {
        [
            questionLabel,
            tagListView,
            nextButton
        ]
            .forEach { view.addSubview($0) }
    }
    
    private func setConstraints() {
        
        questionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
        }
        
        tagListView.snp.makeConstraints { make in
            make.top.equalTo(questionLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
            make.bottom.equalToSuperview()
        }
    }
    
    private func bind() {
        
        //Input
        nextButton.rx.tap
            .bind(onNext: {
                self.navigationController?.pushViewController(WriteReviewRatingViewController(),
                                                              animated: true)
            }).disposed(by: disposeBag)
        
        
        //Output
        tagListView.rx.delegate.onNext(self)
        
        viewModel.isEnableNextButton
            .bind(onNext: {
                self.setNextButtonEnable($0)
            }).disposed(by: disposeBag)
    }
}

extension WriteReviewViewController: TagListViewDelegate {
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        tagView.isSelected.toggle()
        viewModel.tagTapSubject.onNext(tagView.isSelected)
        viewModel.countTapTag()
    }
    
    func setNextButtonEnable(_ isEnable: Bool) {
        if isEnable {
            nextButton.isEnabled = true
            nextButton.backgroundColor = .systemCyan
        } else {
            nextButton.isEnabled = false
            nextButton.backgroundColor = .systemGray2
        }
    }
}
