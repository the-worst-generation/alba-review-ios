//
//  HomeViewController.swift
//  AlbaReview
//
//  Created by 정지훈 on 2023/03/23.
//

import UIKit
import CoreLocation
import NMapsMap


class HomeViewController: UIViewController {

    
    let locationService = LocationManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createMapView()
    }
    
    private func createMapView() {
        let mapView = NMFNaverMapView(frame: view.frame)
        view.addSubview(mapView)
    }
}

