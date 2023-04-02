//
// ReviewViewController.swift
//  AlbaReview
//
//  Created by 정지훈 on 2023/03/25.
//

import UIKit

import SnapKit
import Then
import RxCocoa
import RxSwift
import RxDataSources

class WritableReviewViewController: UIViewController {

    let explainLabel = UILabel().then {
        $0.configureLabel(text: "test", fontSize: 20, color: .black)
    }
    
    let layout = UICollectionViewFlowLayout().then {
        $0.minimumLineSpacing = 20
        $0.scrollDirection = .vertical
    }
     
    
    lazy var writableReviewCollectionView = UICollectionView(frame: .zero,
                                                             collectionViewLayout: layout).then {
        $0.register( WritableReviewCell.self,
                     forCellWithReuseIdentifier:  WritableReviewCell.identifier)
    }
    
    let viewModel = WritableReviewViewModel()
    var datasource: RxCollectionViewSectionedReloadDataSource<WritableReviewSection>!
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
            writableReviewCollectionView
        ].forEach { view.addSubview($0) }
    }

    private func setConstraints() {
        explainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        writableReviewCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(explainLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
        }
        
    }
    
    
    private func bind() {
        
        writableReviewCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        viewModel.writableReviewListOb
            .map { [WritableReviewSection(items: $0)] }
            .bind(to: writableReviewCollectionView.rx.items(dataSource: datasource))
            .disposed(by: disposeBag)
        
    }
}

extension WritableReviewViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    func configureDatasource() {
        datasource = RxCollectionViewSectionedReloadDataSource(configureCell: { _, collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WritableReviewCell.identifier, for: indexPath) as? WritableReviewCell
            else { return UICollectionViewCell() }
            
            cell.configure(item)
            return cell
        })
    }
}
