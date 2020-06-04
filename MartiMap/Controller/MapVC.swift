//
//  MapVC.swift
//  MartiMap
//
//  Created by Zeynebim on 2.06.2020.
//  Copyright © 2020 Zeynebim. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapVC: UIViewController {
    
    // MARK: - IBOulet
    @IBOutlet private weak var locationTitle: UINavigationItem!
    @IBOutlet private weak var mapView: GMSMapView!
    
    // MARK: - Private Variables
    private var mmapView = GMSMapView()
    private var currentLocationCoordinate: CLLocationCoordinate2D? = nil
    private let locationManager = CLLocationManager()
    
    // MARK: - Parameters
    var latFromMap = 0.0
    var longFromMap = 0.0
    var nameFromSearch = ""
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMapView()
    }
    
    // MARK: - Override Function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppConstant.segueIdentifier.mapToDetail.description {
            let destination = segue.destination as! DetailsCV
            destination.lat = latFromMap
            destination.long = longFromMap
            destination.locationName = nameFromSearch
        }
    }
    
    // MARK: - Private Function
    private func configureMapView(){
        let camera = GMSCameraPosition.camera(withLatitude: latFromMap, longitude: longFromMap, zoom: 16.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latFromMap, longitude: longFromMap)
        marker.map = mapView
        marker.isTappable = true
        mapView.delegate = self
    }
}

extension MapVC: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        performSegue(withIdentifier: AppConstant.segueIdentifier.mapToDetail.description, sender: nil)
        return true
    }
}


