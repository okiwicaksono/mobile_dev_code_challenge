//
//  ChatContactCell.swift
//  Chat
//
//  Created by Administrator on 30/05/22.
//

import UIKit

class ChatContactCell: UITableViewCell {

    lazy var contactsView: ContactsView = {
        let view: ContactsView = ContactsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var messageBackgroundView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
        setupLayout()
    }
    
    func setupView() {
        backgroundColor = .clear
        addSubview(messageBackgroundView)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            messageBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            messageBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            messageBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            messageBackgroundView.widthAnchor.constraint(lessThanOrEqualToConstant: 250)
        ])
    }
    
    func setupContactMessage(countContact: Int) {
        contactsView.addCountContacts(count: countContact)
        messageBackgroundView.addSubview(contactsView)

        NSLayoutConstraint.activate([
            contactsView.topAnchor.constraint(equalTo: messageBackgroundView.topAnchor, constant: 8),
            contactsView.leadingAnchor.constraint(equalTo: messageBackgroundView.leadingAnchor, constant: 8),
            contactsView.trailingAnchor.constraint(equalTo: messageBackgroundView.trailingAnchor, constant: -8),
            contactsView.bottomAnchor.constraint(equalTo: messageBackgroundView.bottomAnchor, constant: -8)
        ])
    }
}
