//
//  NetworkManager.swift
//  MartiMap
//
//  Created by Zeynebim on 4.06.2020.
//  Copyright © 2020 Zeynebim. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    var requestMethod: HTTPMethod = .get
    
    func fetchService(request: RequestModel, complationHandler: @escaping (BaseResponseModel?, Error?) -> Void ) {
        guard let url = URL(string: AppConstant.endPoint) else {return}
        
        ActivityIndicator.shared.showIndicator()
        Alamofire.request(url, method: requestMethod, parameters: request.convertToDict(), encoding: URLEncoding(destination: .queryString), headers: nil)
            .validate()
            .responseData { (response) in
                switch response.result {
                case .success(let data):
                    do {
                        let model =  try JSONDecoder().decode(BaseResponseModel.self, from: data)
                        ActivityIndicator.shared.stopIndicator()
                        complationHandler(model, nil)
                    } catch let error {
                        ActivityIndicator.shared.stopIndicator()
                        complationHandler(nil, error)
                    }
                case .failure(let error):
                    ActivityIndicator.shared.stopIndicator()
                    complationHandler(nil, error)
                }
        }
    }
}

