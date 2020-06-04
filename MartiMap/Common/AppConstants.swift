//
//  AppConstants.swift
//  MartiMap
//
//  Created by Zeynebim on 3.06.2020.
//  Copyright © 2020 Zeynebim. All rights reserved.
//

import Foundation

struct AppConstant {
    static let googleApiKey = "AIzaSyDlJTKrXJOJrhs0gG_TxoQIQw_O82jjZ9Q"
    static let endPoint = "https://maps.googleapis.com/maps/api/geocode/json"
    
    enum segueIdentifier: String {
        case mapToDetail = "fromMapToDetail"
        case searchToMap = "fromSearchToMap"
        
        var description: String {
            return self.rawValue
        }
    }
}
