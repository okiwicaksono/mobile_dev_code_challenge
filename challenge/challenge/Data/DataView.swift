//
//  DataView.swift
//  challenge
//
//  Created by Tommy on 13/12/21.
//

import Foundation

enum Criteria: String {
    case text
    case image
    case document
    case contact
}


struct DataView {
    let criteria: Criteria?
    let title: String?
    let detail: [DataDetailView]
    let from: String?
    let to: String?
    let timestamp: Date
}

struct DataDetailView {
    let title: String
    let timestamp: String
}
