//
//  DetailsCV.swift
//  MartiMap
//
//  Created by Zeynebim on 2.06.2020.
//  Copyright © 2020 Zeynebim. All rights reserved.
//

import UIKit

class DetailsCV: UIViewController {
    
    // MARK: - IBOulet
    @IBOutlet private weak var nameLbl: UILabel!
    @IBOutlet private weak var coordinatesLbl: UILabel!
    @IBOutlet private weak var selectedNameLbl: UILabel!
    @IBOutlet private weak var selectedCoordinateLbl: UILabel!
    
    // MARK: - Parameters
    var lat = 0.0
    var long = 0.0
    var locationName = ""
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedNameLbl.text = locationName
        selectedCoordinateLbl.text = String(lat) + ",\n" + String(long)
    }
}
