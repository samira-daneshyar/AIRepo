//
//  ViewController.swift
//  CarRecognition
//
//  Created by Samira Daneshyar on 5/4/18.
//  Copyright © 2018 Samira Daneshyar. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var btnStart: UIButton! {
        didSet {
            btnStart.layer.cornerRadius = 10
            btnStart.clipsToBounds = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocationService.shared.getUserLocation()
    }
}

