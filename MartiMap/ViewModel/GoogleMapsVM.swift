//
//  GoogleMapsVM.swift
//  MartiMap
//
//  Created by Zeynebim on 4.06.2020.
//  Copyright © 2020 Zeynebim. All rights reserved.
//

import Foundation

protocol GoogleMapsDelegate: class {
    func failWith(error: String?)
    func succes()
}

class GoogleMapsVM {
    private var responseModel: BaseResponseModel?
    weak var delegate: GoogleMapsDelegate?
        
    func getGeocode(by text: String) {
        let requestParameter = RequestModel(adress: text)
        NetworkManager.shared.fetchService(request: requestParameter) { (response, error) in
            if let error = error {
                self.delegate?.failWith(error: error.localizedDescription)
                return
            }
            if let response = response {
                if response.status == "ZERO_RESULTS" {
                    self.delegate?.failWith(error: "ZERO_RESULTS return")
                    return
                }
                self.responseModel = response
                self.delegate?.succes()
            }
        }
    }
    
    var g_lat: Double? {
        return BaseResponseVM(model: responseModel).result?.geometry?.location.lat
    }
    
    var g_long: Double? {
        return BaseResponseVM(model: responseModel).result?.geometry?.location.long
    }
    
    var g_address: String? {
        return BaseResponseVM(model: responseModel).result?.formattedAddress
    }
}
