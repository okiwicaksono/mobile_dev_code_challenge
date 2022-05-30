//
//  ChatRepository.swift
//  Chat
//
//  Created by Administrator on 30/05/22.
//

import Foundation

enum Result {
    case success(_ data: [MessageData])
    case failed(_ errorMessage: String?)
}

protocol ChatRepository {
    func getMessageDataSet(completion: @escaping (Result) -> Void)
}

struct ChatDataRepository: ChatRepository {
    func getMessageDataSet(completion: @escaping (Result) -> Void) {
        
        guard let bundle = Bundle.main.url(forResource: "message_dataset", withExtension: "json"),
              let data = try? Data(contentsOf: bundle)
        else {
            completion(.failed("no data json"))
            return
        }
        
        do {
            let objectData = try JSONDecoder().decode(MessageModel.self, from: data)
            guard !objectData.data.isEmpty else {
                completion(.failed("Data Empty"))
                return
            }
            
            completion(.success(objectData.data))
        } catch let error as NSError {
            completion(.failed("\(error.localizedDescription)"))
        }
    }
}
