//
//  CityDetailViewController.swift
//  OpenWeatherMap
//
//  Created by Pedro Magalhaes on 15/11/16.
//  Copyright © 2016 PHMB. All rights reserved.
//

import UIKit

class CityDetailViewController: UIViewController {

    private var city: City?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var weatherDescLabel: UILabel!
    
    
    public init(city: City?) {
        self.city = city
        
        super.init(nibName: "CityDetailViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "City Detail"
        
        self.nameLabel.text = self.city?.name
        self.minTempLabel.text = String(format:"%.2f", (self.city?.minTemperature)!)
        self.maxTempLabel.text = String(format:"%.2f", (self.city?.maxTemperature)!)
        self.weatherDescLabel.text = self.city?.weatherDescription
    }

}
