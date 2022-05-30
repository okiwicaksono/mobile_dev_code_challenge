//
//  FooterView.swift
//  Chat
//
//  Created by Administrator on 30/05/22.
//

import Foundation
import UIKit

class FooterView: UIView {
    
    lazy var dividerView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var mainStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var messageTextfiled: UITextField = {
        let textfield: UITextField = UITextField()
        textfield.borderStyle = .roundedRect
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    lazy var accountImage: UIImageView = {
        let image: UIImageView = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var attachmentImage: UIImageView = {
        let image: UIImageView = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
        setupLayout()
    }
    
    func setupView() {
        backgroundColor = .white
        
        mainStackView.addArrangedSubview(attachmentImage)
        mainStackView.addArrangedSubview(messageTextfiled)
        mainStackView.addArrangedSubview(accountImage)
        
        addSubview(dividerView)
        addSubview(mainStackView)
        
        messageTextfiled.placeholder = "Send Message ...."
        messageTextfiled.delegate = self
        
        attachmentImage.image = UIImage(named: "icon_attachment")?.withRenderingMode(.alwaysTemplate)
        attachmentImage.tintColor = .lightGray
        
        accountImage.image = UIImage(named: "icon_contact")?.withRenderingMode(.alwaysTemplate)
        accountImage.tintColor = .lightGray
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            dividerView.topAnchor.constraint(equalTo: topAnchor),
            dividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            accountImage.widthAnchor.constraint(equalToConstant: 40),
            accountImage.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            attachmentImage.widthAnchor.constraint(equalToConstant: 30),
            attachmentImage.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}

extension FooterView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
}
