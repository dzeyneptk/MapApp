//
//  HelperFunctions.swift
//  MartiMap
//
//  Created by Zeynebim on 4.06.2020.
//  Copyright © 2020 Zeynebim. All rights reserved.
//

import Foundation

extension RequestModel {
    func convertToDict() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }
        let json = String(data: data, encoding: .utf8)
        guard let jsonData = json?.data(using: .utf8, allowLossyConversion: false) else { return [:]}
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        guard let finalDict = dict as? [String: Any] else { return [:]}
        return finalDict
    }
}
