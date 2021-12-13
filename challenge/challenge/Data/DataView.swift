//
//  DataView.swift
//  challenge
//
//  Created by Tommy on 13/12/21.
//

import Foundation

enum Criteria: String {
    case text = "Pesan Text"
    case image = "Pesan Gambar"
    case document = "Pesan Dokumen"
    case contact = "Pesan Kontak"
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
