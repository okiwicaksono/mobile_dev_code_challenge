//
//  DataModel.swift
//  Source
//
//  Created by JAN FREDRICK on 23/08/22.
//

import Foundation

struct DataModel: Decodable {
    
    var data: [ItemList]
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
}

struct ItemList: Decodable {
    var id: Int
    var body: String?
    var attachment: String?
    var timestamp: String
    var from: String
    var to: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case body
        case attachment
        case timestamp
        case from
        case to
    }
}
