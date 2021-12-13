//
//  DataSetEntity.swift
//  challenge
//
//  Created by Tommy on 13/12/21.
//

import UIKit

struct DataResponse: Decodable {
    let data: [DataSetDetail]
}

struct DataSetDetail: Decodable {
    var id: Int?
    var body: String?
    var attachment: String?
    var timestamp: String
    var from: String?
    var to: String?
}
