//
//  ChatTextCell.swift
//  Chat
//
//  Created by Administrator on 30/05/22.
//

import UIKit

class ChatTextCell: UITableViewCell {

    lazy var textMessageLabel: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    func setupTextMessage() {
        messageBackgroundView.addSubview(textMessageLabel)
        
        NSLayoutConstraint.activate([
            textMessageLabel.topAnchor.constraint(equalTo: messageBackgroundView.topAnchor, constant: 8),
            textMessageLabel.leadingAnchor.constraint(equalTo: messageBackgroundView.leadingAnchor, constant: 8),
            textMessageLabel.trailingAnchor.constraint(equalTo: messageBackgroundView.trailingAnchor, constant: -8),
            textMessageLabel.bottomAnchor.constraint(equalTo: messageBackgroundView.bottomAnchor, constant: -8)
        ])
    }

}
