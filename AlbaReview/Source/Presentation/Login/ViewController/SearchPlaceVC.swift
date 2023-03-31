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
import GooglePlaces

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
    
    let placeTableView = UITableView()
    lazy var tableDatasource = GMSAutocompleteTableDataSource().then {
        $0.delegate = self
    }
    let disposeBag = DisposeBag()
    let viewModel = SearchViewModel()
    
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

        placeTableView.rx.setDelegate(tableDatasource)
            .disposed(by: disposeBag)

        placeTableView.rx.setDataSource(tableDatasource)
            .disposed(by: disposeBag)
        
        searchBar.rx.cancelButtonClicked
            .bind(onNext: {
                self.searchBar.endEditing(true)
            }).disposed(by: disposeBag)
        
        searchBar.rx.text
            .orEmpty
            .map { "\($0)" }
            .bind(onNext: {
                print($0)
                self.tableDatasource.sourceTextHasChanged($0)
            }).disposed(by: disposeBag)
        
    }
}

extension SearchPlaceViewController: GMSAutocompleteTableDataSourceDelegate {
    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didAutocompleteWith place: GMSPlace) {
        print("Place: \(place)")
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
        searchBar.endEditing(true)
    }
    
    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didFailAutocompleteWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func didUpdateAutocompletePredictions(for tableDataSource: GMSAutocompleteTableDataSource) {
        placeTableView.reloadData()
    }
    
    func didRequestAutocompletePredictions(for tableDataSource: GMSAutocompleteTableDataSource) {
        placeTableView.reloadData()
    }
    
    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didSelect prediction: GMSAutocompletePrediction) -> Bool {
        return true
    }
}
