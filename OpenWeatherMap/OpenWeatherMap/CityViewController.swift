//
//  CityTableViewController.swift
//  OpenWeatherMap
//
//  Created by Pedro Magalhaes on 14/11/16.
//  Copyright © 2016 PHMB. All rights reserved.
//

import UIKit
import CoreLocation
import PKHUD

class CityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var noConnectionView: UIView!
    
    private var cities: [City]?
    private var openWeatherMapAPIKey: String?
    private var position: CLLocationCoordinate2D?
    
    public init(position: CLLocationCoordinate2D?) {
        self.position = position
        
        super.init(nibName: "CityViewController", bundle: nil)
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
        
        HUD.show(.progress)
        HUD.allowsInteraction = false
        
        let urlString = "http://api.openweathermap.org/data/2.5/find?lat=\(self.position!.latitude)&lon=\(self.position!.longitude)&cnt=15&APPID=\(openWeatherMapAPIKey!)"
        
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            
            DispatchQueue.main.async { () -> Void in
                
                HUD.hide()
                
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
                            
                            self.noConnectionView.isHidden = true
                            self.tableView.reloadData()
                        }
                        
                    } catch {
                        self.errorMessageLabel.text = "An error has occurred"
                        self.noConnectionView.isHidden = false
                    }
                    
                } else {
                    self.errorMessageLabel.text = "Check your connectivity and"
                    self.noConnectionView.isHidden = false
                }
            }
            
        }).resume()
    }

    @IBAction func tryAgainTapped(_ sender: UIButton) {
        self.searchCities()
    }
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities != nil ? self.cities!.count : 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)
        
        let city = self.cities?[indexPath.row]
        
        cell.textLabel?.text = city?.name

        return cell
    }

    // MARK: - Table view delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(CityDetailViewController.init(city: self.cities?[indexPath.row]), animated: true)
    }
    
}
