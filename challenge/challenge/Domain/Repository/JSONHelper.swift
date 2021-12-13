//
//  JSONHelper.swift
//  challenge
//
//  Created by Tommy on 13/12/21.
//

import Foundation

class JSONHelper {
    func loadJson(filename fileName: String) -> DataResponse {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(DataResponse.self, from: data)
                return jsonData
            } catch {
                return DataResponse(data: [])
            }
        }
        return DataResponse(data: [])
    }
}
