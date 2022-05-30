//
//  ImageDetailCell.swift
//  Chat
//
//  Created by Administrator on 31/05/22.
//

import UIKit

class ImageDetailCell: UICollectionViewCell {

    lazy var detailImageView: UIImageView = {
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
        addSubview(detailImageView)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            detailImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            detailImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            detailImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

