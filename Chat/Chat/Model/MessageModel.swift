//
//  MessageModel.swift
//  Chat
//
//  Created by Administrator on 30/05/22.
//

import Foundation

struct MessageModel: Codable {
    let data: [MessageData]
}

// MARK: - Datum
struct MessageData: Codable {
    let id: Int?
    let body: String?
    let attachment: String?
    let timestamp: String?
    let from, to: String?
}
