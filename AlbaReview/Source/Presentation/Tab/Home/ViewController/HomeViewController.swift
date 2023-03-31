//
//  HomeViewController.swift
//  AlbaReview
//
//  Created by 정지훈 on 2023/03/23.
//

import UIKit
import CoreLocation

import NMapsMap
import Then
import SnapKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    lazy var mapView = NMFMapView(frame: view.frame)
    var searchButton: UIButton!
    let currentLocationButton = UIButton().then {
        $0.setImage(UIImage(named: "currentLocation"), for: .normal)
    }
    
    let locationService = LocationManager.shared
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createMapView()
        configureButton()
        setUpUI()
        setAddView()
        setConstraints()
        bind()
    }
    
    private func createMapView() {
        view.addSubview(mapView)
    }

    //MARK: - SetUp
    private func setUpUI() {
        
    }
    
    private func setAddView() {
        [
            mapView,
            searchButton,
            currentLocationButton
        ].forEach { view.addSubview($0) }
    }
    
    private func setConstraints() {
        searchButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(50)
            make.top.equalToSuperview().inset(70)
            make.height.equalTo(50)
        }
        
        currentLocationButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-60)
            make.trailing.equalToSuperview().inset(20)
        }
    }

    private func configureButton() {
        
        var config = UIButton.Configuration.plain()
        let attrTitle = AttributedString.init("구, 동, 장소, 주소 검색")
        
        config.attributedTitle = attrTitle
        config.background.backgroundColor = .white
        config.image = UIImage(systemName: "magnifyingglass")
        config.imagePlacement = .trailing
        config.imagePadding = 70
        config.cornerStyle = .large
        config.baseForegroundColor = .black
        searchButton = UIButton(configuration: config)
    }
    
    private func bind() {
        currentLocationButton.rx.tap
            .bind(onNext: {
                self.mapView.positionMode = .direction
            }).disposed(by: disposeBag)
        
        searchButton.rx.tap
            .bind(onNext: {
                print("asdf")
                let vc = SearchPlaceViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }).disposed(by: disposeBag)
    }
}

