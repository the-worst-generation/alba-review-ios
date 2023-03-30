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

class HomeViewController: UIViewController {

    var searchButton: UIButton!
    let currentLocationButton = UIButton().then {
        $0.setImage(UIImage(named: "currentLocation"), for: .normal)
    }
    
    let locationService = LocationManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createMapView()
        configureButton()
        setUpUI()
        setAddView()
        setConstraints()
    }
    
    private func createMapView() {
        let mapView = NMFMapView(frame: view.frame)
        view.addSubview(mapView)
    }

    //MARK: - SetUp
    private func setUpUI() {
        
    }
    
    private func setAddView() {
        [
            searchButton,
            currentLocationButton
        ].forEach { view.addSubview($0) }
    }
    
    private func setConstraints() {
        searchButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(50)
            make.top.equalToSuperview().inset(70)
        }
        
        currentLocationButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-60)
            make.trailing.equalToSuperview().inset(20)
        }
    }

    private func configureButton() {
        
        var config = UIButton.Configuration.plain()
        var attrTitle = AttributedString.init("구, 동, 장소, 주소 검색")
        //attrTitle.foregroundColor = .systemGray5
        
        config.attributedTitle = attrTitle
        config.background.backgroundColor = .white
        config.image = UIImage(systemName: "magnifyingglass")
        config.imagePlacement = .trailing
        config.imagePadding = 70
        config.cornerStyle = .large
        config.baseForegroundColor = .black
        searchButton = UIButton(configuration: config)
    }
}

