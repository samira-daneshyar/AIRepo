//
//  DealerListController.swift
//  CarRecognition
//
//  Created by Samira Daneshyar on 5/4/18.
//  Copyright © 2018 Samira Daneshyar. All rights reserved.
//

import UIKit
import CoreLocation

class DealerListController: UITableViewController {

    var carInfo: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocationService.shared.startMonitoringLocation()
        
        

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = "test"

        return cell
    }
}

extension DealerListController: LocationServiceDelegate {
    func didFinishGettingUserLocation(location: CLLocation) {
        print(location)
        
        AutoAPI.findDealersNearby(coordinate: location.coordinate, onSuccess: { (dealer) in
            print(dealer)
        }) { (error) in
            print(error)
        }
    }
}
