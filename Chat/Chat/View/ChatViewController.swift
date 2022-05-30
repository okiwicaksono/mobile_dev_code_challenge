//
//  ChatViewController.swift
//  Chat
//
//  Created by Administrator on 30/05/22.
//

import UIKit

class ChatViewController: UIViewController {

    let identifier: String = "textCell"
    
    var type: String = ""
    var countImages = 0
    var newMessageCollection: [MessageType] = []
    
    lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var footerView: FooterView = {
        let view: FooterView = FooterView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var viewModel: ChatViewModel = {
        return ChatViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Chat"
        initViewModel()
        setupViews()
        setupLayout()
        addKeyboardListener()
    }
    
    func initViewModel() {
        viewModel.reloadTableView = { [weak self] () in
            DispatchQueue.main.async {
                self?.getNumberRow()
                self?.tableView.reloadData()
                
            }
        }
        
        viewModel.viewDidLoad()
    }
    
    func setupViews() {
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        view.addSubview(tableView)
        view.addSubview(footerView)
        
        tableView.register(ChatTextCell.self, forCellReuseIdentifier: "textCell")
        tableView.register(ChatImageCell.self, forCellReuseIdentifier: "imageCell")
        tableView.register(ChatContactCell.self, forCellReuseIdentifier: "contactCell")
        tableView.register(ChatDocumentCell.self, forCellReuseIdentifier: "documentCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ChatViewController {
    func addKeyboardListener() {
        let selectorKeyboardWillShow: Selector = #selector(keyboardWillShow(_:))
        let selectorKeyboardWillHide: Selector = #selector(keyboardWillHide(_:))
        
        NotificationCenter.default.addObserver(self, selector: selectorKeyboardWillShow, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: selectorKeyboardWillHide, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo, let keyboardHeight = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height else { return }
        print(keyboardHeight)
        print(footerView.frame.origin.y)
        footerView.frame.origin.y = keyboardHeight + 100
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        footerView.frame.origin.y = 0
    }
    
    @objc
    func actionTapCollectionImages(_ sender: UITapGestureRecognizer) {
        let detailImage = ImageDetailViewController()
        detailImage.addCountImage(count: self.countImages)
        detailImage.title = "Image Detail"
        self.navigationController?.pushViewController(detailImage, animated: true)
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newMessageCollection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if newMessageCollection[indexPath.row].type == AttachmentType.text.rawValue {
            guard let cell: ChatTextCell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath) as? ChatTextCell else {
                return UITableViewCell()
            }

            guard let textMessage = viewModel.chatCollection[AttachmentType.text.rawValue] as? [MessageData] else {
                return UITableViewCell()
            }
            
            let dataMessage = textMessage[indexPath.row].body ?? ""
            
            cell.textMessageLabel.text = dataMessage
            cell.setupTextMessage()

            return cell
        } else if newMessageCollection[indexPath.row].type == AttachmentType.image.rawValue {
            guard let cell: ChatImageCell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as? ChatImageCell else {
                return UITableViewCell()
            }
            
            guard let message = viewModel.chatCollection[AttachmentType.image.rawValue] as? [MessageData] else {
                return UITableViewCell()
            }

            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(actionTapCollectionImages(_:)))
            cell.imagesView.addGestureRecognizer(tapRecognizer)
            self.countImages = message.count
            
            cell.setupImagesMessage(countImages: message.count - 4)

            return cell
        } else if newMessageCollection[indexPath.row].type == AttachmentType.contact.rawValue {
            guard let cell: ChatContactCell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as? ChatContactCell else {
                return UITableViewCell()
            }
            
            guard let message = viewModel.chatCollection[AttachmentType.contact.rawValue] as? [MessageData] else {
                return UITableViewCell()
            }
            
            cell.setupContactMessage(countContact: message.count)

            return cell
            
        }else if newMessageCollection[indexPath.row].type == AttachmentType.document.rawValue {
            guard let cell: ChatDocumentCell = tableView.dequeueReusableCell(withIdentifier: "documentCell", for: indexPath) as? ChatDocumentCell else {
                return UITableViewCell()
            }

            cell.setupDocumentMessage()

            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension ChatViewController {
    
    func getImageCount(dataImage: [MessageData]?) {
        if let imageUnwrapped = dataImage, imageUnwrapped.count > 1 {
            newMessageCollection.append(MessageType(type: AttachmentType.image.rawValue))
        } else if let imageUnwrapped = dataImage, imageUnwrapped.count == 1 {
            newMessageCollection.append(MessageType(type: AttachmentType.image.rawValue))
        }
    }
    
    func getContactCount(dataContact: [MessageData]?) {
        if let contactUnwrapped = dataContact, contactUnwrapped.count > 1 {
            newMessageCollection.append(MessageType(type: AttachmentType.contact.rawValue))
        } else if let contactUnwrapped = dataContact, contactUnwrapped.count == 1 {
            newMessageCollection.append(MessageType(type: AttachmentType.contact.rawValue))
        }
    }
    
    func getDocumentCount(dataDocument: [MessageData]?) {
        
        if let contactUnwrapped = dataDocument, contactUnwrapped.count > 1 {
            newMessageCollection.append(MessageType(type: AttachmentType.document.rawValue))
        } else if let imageUnwrapped = dataDocument, imageUnwrapped.count == 1 {
            newMessageCollection.append(MessageType(type: AttachmentType.document.rawValue))
        }
        
    }
    
    func addTextCollection(dataCount: Int) {
        guard dataCount > 1 else {
            newMessageCollection.append(MessageType(type: AttachmentType.text.rawValue))
            return
        }
        
        for _ in 1...dataCount {
            newMessageCollection.append(MessageType(type: AttachmentType.text.rawValue))
        }
    }
    
    func getNumberRow() {
        viewModel.messageCollection.forEach { item in
            if item.type == AttachmentType.text.rawValue {
                addTextCollection(dataCount: item.messageData.count)
                
            } else if item.type == AttachmentType.image.rawValue {
                getImageCount(dataImage: item.messageData)
            
            } else if item.type == AttachmentType.contact.rawValue {
                getContactCount(dataContact: item.messageData)
                
            } else if item.type == AttachmentType.document.rawValue {
                getDocumentCount(dataDocument: item.messageData)
                
            } else {
                newMessageCollection = []
            }
        }
        
    }
}
