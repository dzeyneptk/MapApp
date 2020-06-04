//
//  BaseResponseModel.swift
//  MartiMap
//
//  Created by Zeynebim on 2.06.2020.
//  Copyright © 2020 Zeynebim. All rights reserved.
//

import Foundation

struct BaseResponseModel : Decodable {
    let results : [Results]?
    let status : String?
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        results = try values.decodeIfPresent([Results].self, forKey: .results)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
    
}

struct Results : Decodable {
    let formatted_address : String?
    let geometry : Geometry?
    
    enum CodingKeys: String, CodingKey {
        case formatted_address = "formatted_address"
        case geometry = "geometry"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        formatted_address = try values.decodeIfPresent(String.self, forKey: .formatted_address)
        geometry = try values.decodeIfPresent(Geometry.self, forKey: .geometry)
    }
}

struct Geometry : Decodable {
    let location : Location?
    
    enum CodingKeys: String, CodingKey {
        case location = "location"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        location = try values.decodeIfPresent(Location.self, forKey: .location)
    }
}

struct Location : Decodable {
    let lat : Double?
    let lng : Double?
    
    enum CodingKeys: String, CodingKey {
        case lat = "lat"
        case lng = "lng"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lat = try values.decodeIfPresent(Double.self, forKey: .lat)
        lng = try values.decodeIfPresent(Double.self, forKey: .lng)
    }
}
