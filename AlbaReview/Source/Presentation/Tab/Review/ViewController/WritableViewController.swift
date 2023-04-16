//
//  WritableViewController.swift
//  AlbaReview
//
//  Created by 정지훈 on 2023/04/02.
//

import UIKit

import Then
import SnapKit
import RxCocoa
import RxDataSources
import RxSwift

class WritableReviewViewController: UIViewController {
    
    let explainLabel = UILabel().then {
        $0.configureLabel(text: "test", fontSize: 18, color: .black)
    }
    
    let layout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
        $0.minimumInteritemSpacing = 20
    }
    
    lazy var placeCollectionView = UICollectionView(frame: .zero,
                                               collectionViewLayout: layout).then {
        $0.register(WritableReviewCell.self,
                    forCellWithReuseIdentifier:WritableReviewCell.identifier)
    }
    
    var datasource: RxCollectionViewSectionedReloadDataSource<WritableReviewSection>!
    let viewModel = WritableReviewViewModel.shared
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        setAddView()
        setConstraints()
        configureDatasource()
        
        bind()
    }
    
    //MARK: - SetUp
    private func setUpUI() {
        view.backgroundColor = .white
    }
    private func setAddView() {
        [
            explainLabel,
            placeCollectionView
        ].forEach { view.addSubview($0) }
    }
    
    private func setConstraints() {
        
        explainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
        
        placeCollectionView.snp.makeConstraints { make in
            make.top.equalTo(explainLabel.snp.bottom).offset(10)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    private func bind() {
        
        //Input
        placeCollectionView.rx.modelSelected(WritableReviewData.self)
            .bind(onNext: {
                self.viewModel.selectedModelSubject.onNext($0)
            })
            .disposed(by: disposeBag)
        
        //Output
        viewModel.writableReviewListSubject
            .map { $0 }
            .bind(to: placeCollectionView.rx.items(dataSource: datasource))
            .disposed(by: disposeBag)
        
        placeCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        viewModel.isSelectedItem
            .filter { $0 }
            .bind(onNext: { _ in
                let vc = WriteReviewViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: disposeBag)
    }
    
}

extension WritableReviewViewController: UICollectionViewDelegateFlowLayout {
    
    func configureDatasource () {
        datasource = RxCollectionViewSectionedReloadDataSource(configureCell: { _, collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WritableReviewCell.identifier, for: indexPath) as? WritableReviewCell
            else { return UICollectionViewCell() }
            
            cell.configure(item)
            
            return cell
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
}
