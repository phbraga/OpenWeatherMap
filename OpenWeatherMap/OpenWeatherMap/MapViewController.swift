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

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var searchButton: UIButton!
    
    private var currentMarker : GMSMarker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Map"
        self.mapView?.delegate = self
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        self.navigationController?.pushViewController(CityTableViewController.init(position: self.currentMarker?.position), animated: true)
    }
    
    //MARK: GMSMapViewDelegate
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        
        if currentMarker == nil {
            self.currentMarker = GMSMarker.init()
        }
        
        self.searchButton.isEnabled = true
        self.currentMarker!.position = coordinate
        self.currentMarker!.title = "Click on Search Button"
        self.currentMarker!.snippet = "\tto find nearest 15 cities"
        self.currentMarker!.map = self.mapView
    }

}
