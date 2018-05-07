//
//  CarController.swift
//  CarRecognition
//
//  Created by Samira Daneshyar on 5/4/18.
//  Copyright © 2018 Samira Daneshyar. All rights reserved.
//

import UIKit

class CarController: UIViewController, ClassificationServiceDelegate {
    
    var capturedCIImage: CIImage?
    
    fileprivate let classificationService = ClassificationService()
    
    @IBOutlet weak var imageCar: UIImageView!
    @IBOutlet weak var lblModel: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnDealers: UIButton! {
        didSet {
            btnDealers.layer.cornerRadius = 10
            btnDealers.clipsToBounds = true
            btnDealers.addTarget(self, action: #selector(toMapController), for: .touchUpInside)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        classificationService.delegate = self
        classificationService.setup()

        if let ciimage = capturedCIImage {
            imageCar.image = UIImage(ciImage: ciimage)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let ciimage = capturedCIImage else { return }
        
        classificationService.classify(image: ciimage)
    }
    
    func classificationService(_ service: ClassificationService, didDetectCar car: String) {
        lblModel.text = car.capitalized
        
        guard let location = LocationService.shared.location else { return }
        
        let carInfoArray = car.capitalized.split(separator: " ")
        let make = String(carInfoArray.first ?? "")
        let model = String(((carInfoArray.count) > 1) ? carInfoArray[1] : "")
        
        AutoAPI.searchVehiclesNearby(coordinate: location.coordinate, make: make, model: model, onSuccess: { (vehicles) in
            let prices = vehicles.compactMap { $0.refPrice }
            let averagePrice = prices.isEmpty ? 0 : prices.reduce(0) { $0 + $1 } / Double(prices.count)
            
            self.lblPrice.text = "Estimate: \(averagePrice)"
        }) { (error) in
            print(error)
        }
    }
    
    @objc func toMapController() {
        performSegue(withIdentifier: "toMapController", sender: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
