//
//  ContactsView.swift
//  Chat
//
//  Created by Administrator on 30/05/22.
//

import Foundation
import UIKit

protocol ContactsViewInput: AnyObject {
    func addCountContacts(count: Int)
}

class ContactsView: UIView {
    
    lazy var mainStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var arrowView: UIView = {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var contactContentView: UIView = {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var contactsImage: UIImageView = {
        let image: UIImageView = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var contactLabel: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 0
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var arrowImage: UIImageView = {
        let image: UIImageView = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var dividerView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let viewAllButton: UIButton = {
        let button: UIButton = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
        setupLayouts()
    }
    
    func setupViews() {
        backgroundColor = .white

        contactContentView.addSubview(contactsImage)
        contactContentView.addSubview(contactLabel)
        
        arrowView.addSubview(arrowImage)
        
        mainStackView.addArrangedSubview(contactContentView)
        mainStackView.addArrangedSubview(arrowView)
        
        addSubview(mainStackView)
        addSubview(dividerView)
        addSubview(viewAllButton)
        
        viewAllButton.setTitle("View All", for: .normal)
        contactsImage.image = UIImage(named: "icon_contact")?.withRenderingMode(.alwaysTemplate)
        contactsImage.tintColor = .lightGray
        arrowImage.image = UIImage(named: "icon_chevron")?.withRenderingMode(.alwaysTemplate)
        arrowImage.tintColor = .lightGray
        
        layer.cornerRadius = 5
        layer.masksToBounds = true
        
    }
    
    func setupLayouts() {
        NSLayoutConstraint.activate([
            arrowImage.centerYAnchor.constraint(equalTo: arrowView.centerYAnchor),
            arrowImage.centerXAnchor.constraint(equalTo: arrowView.centerXAnchor),
            arrowImage.heightAnchor.constraint(equalToConstant: 15),
            arrowImage.widthAnchor.constraint(equalToConstant: 15)
        ])
        
        NSLayoutConstraint.activate([
            contactsImage.topAnchor.constraint(equalTo: contactContentView.topAnchor, constant: 8),
            contactsImage.leadingAnchor.constraint(equalTo: contactContentView.leadingAnchor, constant: 8),
            contactsImage.bottomAnchor.constraint(equalTo: contactContentView.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            contactLabel.topAnchor.constraint(equalTo: contactContentView.topAnchor, constant: 8),
            contactLabel.leadingAnchor.constraint(equalTo: contactsImage.trailingAnchor, constant: 8),
            contactLabel.trailingAnchor.constraint(equalTo: contactContentView.trailingAnchor, constant: -8),
            contactLabel.bottomAnchor.constraint(equalTo: contactContentView.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            dividerView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 16),
            dividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            viewAllButton.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 8),
            viewAllButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            viewAllButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            viewAllButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}

extension ContactsView: ContactsViewInput {
    func addCountContacts(count: Int) {
        contactLabel.text = "\(count) Other contacts"
    }
}
