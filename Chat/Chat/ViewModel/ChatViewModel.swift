//
//  ChatViewModel.swift
//  Chat
//
//  Created by Administrator on 30/05/22.
//

import Foundation

protocol ChatViewModelInput {
    func viewDidLoad()
}

class ChatViewModel: ChatViewModelInput {
    
    let chatRepository = ChatDataRepository()
    var chatCollection = [String: Any]()
    var messageCollection = [MessageCollection]()
    
    var reloadTableView: (()->())?
    
    func viewDidLoad() {
        chatRepository.getMessageDataSet { result in
            switch result {
            case .success(let data):

                let sourceMessage = data.filter({$0.from == MessageUser.userA.rawValue})
                
                let textMessage = sourceMessage.filter({ $0.attachment == nil })
                
                let imageMessage = sourceMessage.filter({ $0.attachment == AttachmentType.image.rawValue })
                
                let documentMessage = sourceMessage.filter({ $0.attachment == AttachmentType.document.rawValue })
                
                let contactMessage = sourceMessage.filter({ $0.attachment == AttachmentType.contact.rawValue })
                
                let dataCollection = [
                    AttachmentType.text.rawValue: textMessage,
                    AttachmentType.image.rawValue: imageMessage,
                    AttachmentType.document.rawValue: documentMessage,
                    AttachmentType.contact.rawValue: contactMessage
                ]
                
                let collection = [
                    MessageCollection(type: AttachmentType.text.rawValue, messageData: textMessage),
                    MessageCollection(type: AttachmentType.image.rawValue, messageData: imageMessage),
                    MessageCollection(type: AttachmentType.contact.rawValue, messageData: contactMessage),
                    MessageCollection(type: AttachmentType.document.rawValue, messageData: documentMessage)
                ]
                
                self.chatCollection = dataCollection
                self.messageCollection = collection
                
                self.reloadTableView?()
            case .failed(let errorMessage):
                print("errorMessage: \(errorMessage)")
            }
        }
    }
    
}

struct MessageCollection {
    var type: String?
    var messageData: [MessageData] = []
    
    init(type: String? = "", messageData: [MessageData] = []) {
        self.type = type
        self.messageData = messageData
    }
}

struct MessageType {
    var type: String = ""
    
    init(type: String = "") {
        self.type = type
    }
}

enum AttachmentType: String {
    case image = "image"
    case contact = "contact"
    case document = "document"
    case text = "text"
}

enum MessageUser: String {
    case userA = "A"
    case userB = "B"
}
