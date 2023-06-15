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
    
    let placeInfoView: UIView = UIView().then {
        $0.backgroundColor = .white
        $0.isHidden = true
    }
    
    let placeNameLabel: UILabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18)
    }
    
    let heartImageButton: UIButton = UIButton().then {
        $0.tintColor = .systemRed
        $0.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    }
    
    let reviewLabel: UILabel = UILabel().then {
        $0.configureLabel(text: "리뷰 개수", fontSize: 14, color: .black)
    }
    
    let reviewCountLabel: UILabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
    }
    
    let starImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "star.fill")
        $0.tintColor = .systemYellow
    }
    
    let starLabel: UILabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
    }
    
    let goodImageView: UIImageView = UIImageView().then {
        $0.tintColor = .systemRed
        $0.image = UIImage(systemName: "hand.thumbsup")
    }
    
    let badImageView: UIImageView = UIImageView().then {
        $0.tintColor = .systemBlue
        $0.image = UIImage(systemName: "hand.thumbsdown")
    }
    
    
    let locationService = LocationManager.shared
    
    let reviewViewModel = WritableReviewViewModel.shared
    let searchViewModel = SearchViewModel.shared
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
        mapView.touchDelegate = self
    }

    //MARK: - SetUp
    private func setUpUI() {
        
    }
    
    private func setAddView() {
        
        [
            placeNameLabel,
            heartImageButton,
            reviewLabel,
            reviewCountLabel,
            starImageView,
            starLabel,
            goodImageView,
            badImageView
        ]   .forEach { placeInfoView.addSubview($0) }
        
        [
            mapView,
            searchButton,
            currentLocationButton,
            placeInfoView
        ]   .forEach { view.addSubview($0) }
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
        
        placeInfoView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(200)
        }
        
        placeNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(20)
        }
        
        heartImageButton.snp.makeConstraints { make in
            make.leading.equalTo(placeNameLabel.snp.trailing).offset(5)
            make.top.equalToSuperview().inset(20)
            make.height.width.equalTo(20)
        }
        
        reviewLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(placeNameLabel.snp.bottom).offset(10)
        }
        
        reviewCountLabel.snp.makeConstraints { make in
            make.leading.equalTo(reviewLabel.snp.trailing).offset(5)
            make.top.equalTo(reviewLabel.snp.top)
        }
        
        starImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(reviewLabel.snp.bottom).offset(10)
            make.width.height.equalTo(20)
        }
        
        starLabel.snp.makeConstraints { make in
            make.leading.equalTo(starImageView.snp.trailing).offset(5)
            make.bottom.equalTo(starImageView.snp.bottom)
        }
        
        badImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(30)
            make.width.height.equalTo(30)
        }
        
        goodImageView.snp.makeConstraints { make in
            make.trailing.equalTo(badImageView.snp.leading).offset(-20)
            make.bottom.equalToSuperview().inset(30)
            make.width.height.equalTo(30)
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
        
        //Input
        currentLocationButton.rx.tap
            .bind(onNext: {
                self.mapView.positionMode = .direction
            }).disposed(by: disposeBag)
        
        searchButton.rx.tap
            .bind(onNext: {
                let vc = SearchPlaceViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }).disposed(by: disposeBag)
        
        //Output
        reviewViewModel.writedReview
            .filter { $0 != nil}
            .compactMap { $0 }
            .bind(onNext: {
                self.createMarker($0)
            }).disposed(by: disposeBag)
        
        searchViewModel.selectedPlaceSubject
            .skip(1)
            .bind(onNext: {
                self.moveToSearchPlace(Double($0.x)!, y: Double($0.y)!)
            }).disposed(by: disposeBag)
        
    }
}

extension HomeViewController: NMFMapViewTouchDelegate {
    
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        print("asdf")
        placeInfoView.isHidden = true
        tabBarController?.tabBar.isHidden = false
    }
    
    func createMarker(_ data: WritableReviewData) {
        let marker = NMFMarker()
        marker.position = NMGLatLng(lat: data.lattitude, lng: data.longtitude)
        marker.captionText = data.name
        marker.mapView = mapView
        
        marker.touchHandler = { (overlay: NMFOverlay) -> Bool in
            self.setPlaceInfoView(data: data)
            return true
        }
    }
    
    func moveToSearchPlace(_ x: Double, y: Double) {
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: y, lng: x))
        mapView.moveCamera(cameraUpdate)
    }
    
    func setPlaceInfoView(data: WritableReviewData) {
        tabBarController?.tabBar.isHidden = true
        placeInfoView.isHidden = false
        placeNameLabel.text = data.name
        reviewCountLabel.text = String(data.reviewCount)
        starLabel.text = String(data.rating)
    }
}
