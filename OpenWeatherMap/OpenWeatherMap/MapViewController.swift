//
//  MapViewController.swift
//  OpenWeatherMap
//
//  Created by Pedro Magalhaes on 14/11/16.
//  Copyright © 2016 PHMB. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, GMSMapViewDelegate {

    @IBOutlet weak var mapView: GMSMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView?.delegate = self
    }
    
    //MARK: GMSMapViewDelegate
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        
    }

}
