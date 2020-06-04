//
//  BaseResponseVM.swift
//  MartiMap
//
//  Created by Zeynebim on 4.06.2020.
//  Copyright © 2020 Zeynebim. All rights reserved.
//

import Foundation

struct BaseResponseVM {
    private var responseModel: BaseResponseModel?
    
    init(model: BaseResponseModel?) {
        self.responseModel = model
    }
    
    var result: ResultVM? {
        guard let response = responseModel else { return nil }
        return ResultVM(model: response.results?[0])
    }
    var status: String {
        return responseModel?.status ?? ""
    }
}

struct ResultVM {
    private var responseModel: Results?
    init(model: Results?){
        self.responseModel = model
    }
    
    var formattedAddress: String {
        return responseModel?.formatted_address ?? ""
    }
    
    var geometry: GeometryVM? {
        guard let response = responseModel else { return nil }
        return GeometryVM(model: response.geometry)
    }
    
}

struct GeometryVM {
    private var responseModel: Geometry?
    init(model: Geometry?) {
        self.responseModel = model
    }
    
    var location: LocationVM {
        return LocationVM(model: responseModel?.location)
    }
}

struct LocationVM {
    private var responseModel: Location?
    init(model: Location?) {
        self.responseModel = model
    }
    
    var lat: Double {
        return responseModel?.lat ?? 0.0
    }
    
    var long: Double {
        return responseModel?.lng ?? 0.0
    }
}
