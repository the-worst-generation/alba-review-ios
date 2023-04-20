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

class SearchPlaceViewController: UIViewController {
    
    let searchBar = UISearchBar().then {
        $0.barTintColor = .clear
        $0.barStyle = .black
        $0.backgroundColor = .white
        $0.isTranslucent = true
        $0.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        $0.showsCancelButton = true
        $0.placeholder = "장소, 주소를 검색해보세요"
    }
    
    let placeTableView = UITableView().then {
        $0.register(SearchCell.self, forCellReuseIdentifier: SearchCell.identifier)
    }
    let disposeBag = DisposeBag()
    let viewModel = SearchViewModel.shared
    
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
            searchBar,
            placeTableView
        ]   .forEach { view.addSubview($0) }
        
    }
    
    private func setConstraints() {
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        placeTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func bind() {

        searchBar.rx.text
            .orEmpty
            .skip(1)
            .filter { $0 != "" }
            .bind(to: viewModel.searchTextSubject)
            .disposed(by: disposeBag)
        
        searchBar.rx.cancelButtonClicked
            .bind(onNext: {
                self.searchBar.endEditing(true)
            }).disposed(by: disposeBag)
        
        viewModel.placeList
            .map { $0.documents }
            .bind(to: viewModel.searchPlaceList)
            .disposed(by: disposeBag)
        
        placeTableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
       
        viewModel.searchPlaceList
            .bind(to: placeTableView.rx.items(
                cellIdentifier: SearchCell.identifier,
                cellType: SearchCell.self)) { (row, item, cell) in
                    cell.configure(data: item)
                }.disposed(by: disposeBag)
        
        
    }
}

extension SearchPlaceViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
