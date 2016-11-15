//
//  CityTableViewController.swift
//  OpenWeatherMap
//
//  Created by Pedro Magalhaes on 14/11/16.
//  Copyright © 2016 PHMB. All rights reserved.
//

import UIKit
import CoreLocation

class CityTableViewController: UITableViewController {
    
    private var cities: [City]?
    private var openWeatherMapAPIKey: String?
    private var position: CLLocationCoordinate2D?
    
    public init(position: CLLocationCoordinate2D?) {
        self.position = position
        
        super.init(nibName: "CityTableViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "CityCell")
        self.title = "Cities"
        
        self.openWeatherMapAPIKey = "4ad612f2cfee3be8946ec1a61d91bd5d"
        self.searchCities()
    }
    
    private func searchCities () -> Void {
        let urlString = "http://api.openweathermap.org/data/2.5/find?lat=\(self.position!.latitude)&lon=\(self.position!.longitude)&cnt=15&APPID=\(openWeatherMapAPIKey!)"
        
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
        
            if error == nil {
                
                do {
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: Any]
                    self.cities = [City]()
                    
                    if let citiesDictionary = parsedData["list"] as? NSArray {
                        for city in citiesDictionary {
                            if let cityMap = city as? [String: AnyObject] {
                                let newCity = City.init(cityMap)
                                self.cities?.append(newCity)
                            }
                        }
                        
                        DispatchQueue.main.async { self.tableView.reloadData() }
                    }
                    
                } catch {
                    self.showAlertMessage("Ups!", "An Error Occurred")
                }
                
            } else {
                self.showAlertMessage("Ups!", "An Error Occurred")
            }
            
        }).resume()
    }
    
    private func showAlertMessage(_ title: String?, _ message: String) -> Void {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities != nil ? self.cities!.count : 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)
        
        let city = self.cities?[indexPath.row]
        
        cell.textLabel?.text = city?.name

        return cell
    }

    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(CityDetailViewController.init(city: self.cities?[indexPath.row]), animated: true)
    }
    
}
