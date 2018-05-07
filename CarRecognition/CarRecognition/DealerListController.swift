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
    var dealers = [Dealer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        LocationService.shared.startMonitoringLocation()
//        LocationService.shared.delegate = self
        
        guard let location = LocationService.shared.location else { return }
        AutoAPI.findDealersNearby(coordinate: location.coordinate, onSuccess: { (dealer) in
            print(dealer)
            self.dealers = dealer
            self.tableView.reloadData()
            
        }) { (error) in
            print(error)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dealers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let dealer = dealers[indexPath.row]
        // a simple label
        cell.textLabel?.text = "\(String(describing: dealer.sellerName)) from \(String(describing: dealer.distance))km away"

        return cell
    }
}

//extension DealerListController: LocationServiceDelegate {
//    func didFinishGettingUserLocation(location: CLLocation) {
//        print(location)
//
//
//    }
//}
