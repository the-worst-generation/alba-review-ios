//
//  HomeViewController.swift
//  AlbaReview
//
//  Created by 정지훈 on 2023/03/23.
//

import UIKit

class HomeViewController: UIViewController, MTMapViewDelegate {

    var mapView: MTMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = MTMapView(frame: view.bounds)
        if let mapView = mapView {
            mapView.delegate = self
            mapView.baseMapType = .standard
            view.addSubview(mapView)
        }
    }
}
