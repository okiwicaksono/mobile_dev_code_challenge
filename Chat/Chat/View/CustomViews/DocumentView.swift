//
//  DocumentView.swift
//  Chat
//
//  Created by Administrator on 30/05/22.
//

import Foundation
import UIKit

class DocumentView: UIView {
    
    lazy var documentImage: UIImageView = {
        let image: UIImageView = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var descLabel: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 0
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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

        addSubview(documentImage)
        addSubview(descLabel)
        
        descLabel.text = "This is document"
        documentImage.image = UIImage(named: "icon_document")?.withRenderingMode(.alwaysTemplate)
        documentImage.tintColor = .lightGray
        
        layer.cornerRadius = 5
        layer.masksToBounds = true
        
    }
    
    func setupLayouts() {
        NSLayoutConstraint.activate([
            
            descLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            descLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            descLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            documentImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            documentImage.trailingAnchor.constraint(equalTo: descLabel.leadingAnchor, constant: -8),
            documentImage.centerYAnchor.constraint(equalTo: descLabel.centerYAnchor),
            documentImage.heightAnchor.constraint(equalToConstant: 20),
            documentImage.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
}
