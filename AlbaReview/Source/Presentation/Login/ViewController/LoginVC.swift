//
//  ViewController.swift
//  AlbaReview
//
//  Created by 정지훈 on 2023/03/17.
//


import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa
import CoreLocation

class LoginViewController: UIViewController {

    //MARK: - Property
    
    let loginStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 12
    }
    var googleLoginButton: UIButton!
    var appleLoginButton: UIButton!
    var kakaoLoginButton: UIButton!
    var naverLoginButton: UIButton!
    
    
    let noLoginButton = UIButton().then {
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 12)
        $0.sizeToFit()
        $0.setTitle("로그인없이 사용하기", for: .normal)
    }
    
    let disposeBag = DisposeBag()
    var locationManger: CLLocationManager!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setUpUI()
        setAddView()
        setUpConstraints()
        bind()
        
        locationManger =  CLLocationManager()
        locationManger.delegate = self
        locationManger.requestWhenInUseAuthorization()
        locationManger.startUpdatingLocation()
    }
    
    //MARK: - SetUp
    private func setUpUI() {
        view.backgroundColor = .white

        //Button SetUp
        googleLoginButton = UIButton(
            configuration: setConfigButton(
                "구글로 시작하기",
                color: .black,
                imageName: "google",
                backgroundColor: .white,
                padding: 80))
        
        //button shadown
        googleLoginButton.layer.shadowColor = UIColor.black.cgColor
        googleLoginButton.layer.shadowOpacity = 0.25
        googleLoginButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        googleLoginButton.layer.shadowRadius = 2
        
        appleLoginButton = UIButton(
            configuration: setConfigButton(
                "애플로 시작하기",
                color: .white,
                imageName: "apple",
                backgroundColor: .black,
                padding: 80))
        
        kakaoLoginButton = UIButton(
            configuration: setConfigButton(
                "카카오톡으로 시작하기",
                color: .black,
                imageName: "kakaotalk",
                backgroundColor: #colorLiteral(red: 0.9983025193, green: 0.9065476656, blue: 0, alpha: 1),
                padding: 60,
                rightPadding: 102))
        
        naverLoginButton = UIButton(
            configuration: setConfigButton(
                "네이버로 시작하기",
                color: .white,
                imageName: "naver",
                backgroundColor: #colorLiteral(red: 0.01176470588, green: 0.7803921569, blue: 0.3529411765, alpha: 1),
                padding: 67,
                rightPadding: 120))
    }
    
    private func setConfigButton(_ title: String,
                                 color: UIColor,
                                 imageName: String,
                                 backgroundColor: UIColor,
                                 padding: CGFloat,
                                 rightPadding: CGFloat = 120) -> UIButton.Configuration {
        var config = UIButton.Configuration.plain()
        
        var titleAttr = AttributedString.init(title)
        titleAttr.font = .systemFont(ofSize: 14)
        titleAttr.foregroundColor = color
        
        config.attributedTitle = titleAttr
        config.background.backgroundColor = backgroundColor
        config.image = UIImage(named: imageName)
        config.imagePadding = padding
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 0, trailing: rightPadding)
        return config
        
    }

    private func setAddView() {
        [
            googleLoginButton,
            appleLoginButton,
            kakaoLoginButton,
            naverLoginButton
        ]       .forEach { loginStackView.addArrangedSubview($0)}
        
        [
            loginStackView,
            noLoginButton
        ]      .forEach { view.addSubview($0)}
    }
    
    private func setUpConstraints() {
       
        loginStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.height.equalTo(206)
        }
        
        noLoginButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.centerX.equalToSuperview()
        }
    }
    
    private func bind() {
        googleLoginButton.rx.tap
            .bind(onNext: {
                let vc = LoginNickNameViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: disposeBag)
        
        noLoginButton.rx.tap
            .bind(onNext: {
                let tabBar = AppTabBarController()
                tabBar.modalPresentationStyle = .fullScreen
                
                self.present(tabBar, animated: true)
            }).disposed(by: disposeBag)
    }
    
}

extension LoginViewController: CLLocationManagerDelegate {
    func getLocationUsagePermission() {
        self.locationManger.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined, .restricted:
            print("Gps 권한 설정되지 않음")
            getLocationUsagePermission()
        case .denied:
            print("GPS 권한 요청 거부")
        case .authorizedAlways, .authorizedWhenInUse:
            getLocationUsagePermission()
            print("GPS 권한 설정됨")
        default:
            print("GPS Default")
        }
    }
}