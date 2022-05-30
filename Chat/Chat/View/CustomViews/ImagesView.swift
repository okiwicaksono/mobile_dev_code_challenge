//
//  ImagesView.swift
//  Chat
//
//  Created by Administrator on 30/05/22.
//

import Foundation
import UIKit

protocol ImagesViewInput: AnyObject {
    func addCountImages(count: Int)
}

class ImagesView: UIView {
    
    lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let images: [String] = ["abc", "def", "ghi", "jkl", "mno", "pqr", "stu", "vwx", "yz"]
    let limitCell: Int = 4
    var countImages: Int = 0
    
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
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 6
        layout.sectionInset = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        layout.scrollDirection = .vertical
        
        collectionView.register(ImageListCell.self, forCellWithReuseIdentifier: "imageListCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.layer.cornerRadius = 5
        collectionView.isScrollEnabled = false
        collectionView.bounces = false
        
        addSubview(collectionView)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.size.height - 80) / 2),
            collectionView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width - 80)
        ])
    }
    
}

extension ImagesView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return limitCell
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: ImageListCell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageListCell", for: indexPath) as? ImageListCell else {
            return UICollectionViewCell()
        }
        
        if indexPath.row == limitCell - 1 {
            cell.setupLabelMore(text: "+\(countImages)")
            cell.setupAlphaTransparantView(alphaNumber: 0.5)
        }
        
        cell.imageChat.image = UIImage(named: "image_chat")
        
        return cell
    }
}

extension ImagesView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.size.width - 16) / 2, height: (collectionView.bounds.size.height - 16) / 2)
    }
}

extension ImagesView: ImagesViewInput {
    func addCountImages(count: Int) {
        countImages = count
    }
}
