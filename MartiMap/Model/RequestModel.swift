//
//  RequestModel.swift
//  MartiMap
//
//  Created by Zeynebim on 4.06.2020.
//  Copyright © 2020 Zeynebim. All rights reserved.
//

import Foundation

struct RequestModel: Codable {
    var address: String
    var sensor: Bool
    var key: String
    
    init(adress: String, sensor: Bool = false, key: String = AppConstant.googleApiKey) {
        self.address = adress
        self.sensor = sensor
        self.key = key
    }
}
