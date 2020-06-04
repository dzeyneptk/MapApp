//
//  GooglePlaceVM.swift
//  MartiMap
//
//  Created by Zeynebim on 4.06.2020.
//  Copyright © 2020 Zeynebim. All rights reserved.
//

import Foundation
import GoogleMaps
import GooglePlaces


protocol GooglePlaceDelegate: class {
    func failure(error: String?)
    func success()
}

class GooglePlaceVM {
    private var resultsArray: [String] = []
    weak var delegate: GooglePlaceDelegate?
    
    // MARK: - GooglePlaceService
    func placeAutoComplete(text input: String) {
        let filter = GMSAutocompleteFilter()
        let placesClient = GMSPlacesClient()
        filter.type = .establishment
        
        let bounds = GMSCoordinateBounds(coordinate: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), coordinate: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0))
        
        ActivityIndicator.shared.showIndicator()
        placesClient.autocompleteQuery(input, bounds: bounds, filter: nil) { (results, error) -> Void in
            self.resultsArray.removeAll()
            if let error = error {
                ActivityIndicator.shared.stopIndicator()
                self.delegate?.failure(error: error.localizedDescription)
                return
            }
            if let results = results {
                for result in results {
                    ActivityIndicator.shared.stopIndicator()
                    self.resultsArray.append(result.attributedFullText.string)
                    self.delegate?.success()
                }
            }
        }
    }
    
    var placeCount: Int {
        return resultsArray.count
    }
    var getArray: [String] {
        return resultsArray
    }
}
