//
//  HomeViewController.swift
//  AlbaReview
//
//  Created by 정지훈 on 2023/03/23.
//

import UIKit
import CoreLocation


class HomeViewController: UIViewController, MTMapViewDelegate {

    var mapView: MTMapView?
    
    let locationService = LocationManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createMapView()
    }
    
    private func createMapView() {
        
//        locationService.locationManager.delegate = self
        mapView = MTMapView(frame: view.bounds)
        if let mapView = mapView {
            mapView.delegate = self
            mapView.baseMapType = .standard
            
            mapView.setMapCenter(MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.576568,
                                                                    longitude: 127.029148)),
                                 animated: true)
            mapView.showCurrentLocationMarker = true
            
            DispatchQueue.global().async {
                if CLLocationManager.locationServicesEnabled() {
                    mapView.currentLocationTrackingMode = .onWithoutHeading
                }
            }
            view.addSubview(mapView)
        }
    }
}

