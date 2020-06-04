//
//  ActivityIndicatorHelper.swift
//  MartiMap
//
//  Created by Zeynebim on 4.06.2020.
//  Copyright © 2020 Zeynebim. All rights reserved.
//

import UIKit

class ActivityIndicator {
    static let shared = ActivityIndicator()
    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    private var topVCView = UIApplication.shared.windows.first?.rootViewController?.view
    
    func showIndicator() {
        configureIndicatorView()
        activityIndicator.startAnimating()
    }
    
    func stopIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
    
    private func configureIndicatorView() {
        activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        activityIndicator.center = topVCView?.center ?? CGPoint(x: 0.0, y: 0.0)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        topVCView?.addSubview(activityIndicator)
    }
}
