//
//  ImageListCell.swift
//  Chat
//
//  Created by Administrator on 30/05/22.
//

import UIKit

class ImageListCell: UICollectionViewCell {
    
    lazy var imageChat: UIImageView = {
        let image: UIImageView = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var transparantView: UIView = {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var moreLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        transparantView.addSubview(moreLabel)
        addSubview(imageChat)
        addSubview(transparantView)
        isSelected = false
        
        imageChat.layer.cornerRadius = 5
        imageChat.layer.masksToBounds = true
        
        transparantView.layer.cornerRadius = 5
        transparantView.layer.masksToBounds = true
        
    }
    
    func setupLayout() {
        
        NSLayoutConstraint.activate([
            moreLabel.leadingAnchor.constraint(equalTo: transparantView.leadingAnchor, constant: 8),
            moreLabel.trailingAnchor.constraint(equalTo: transparantView.trailingAnchor, constant: -8),
            moreLabel.bottomAnchor.constraint(equalTo: transparantView.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            imageChat.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageChat.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageChat.topAnchor.constraint(equalTo: topAnchor),
            imageChat.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            transparantView.leadingAnchor.constraint(equalTo: leadingAnchor),
            transparantView.trailingAnchor.constraint(equalTo: trailingAnchor),
            transparantView.topAnchor.constraint(equalTo: topAnchor),
            transparantView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupAlphaTransparantView(alphaNumber: CGFloat) {
        transparantView.backgroundColor = .black
        transparantView.alpha = alphaNumber
    }
    
    func setupLabelMore(text: String) {
        moreLabel.textColor = .white
        moreLabel.font = UIFont.boldSystemFont(ofSize: 16)
        moreLabel.text = [text, "More..."].joined(separator: " ")
    }
}
