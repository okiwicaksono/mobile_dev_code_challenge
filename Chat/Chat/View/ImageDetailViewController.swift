//
//  ImageDetailViewController.swift
//  Chat
//
//  Created by Administrator on 31/05/22.
//

import UIKit

protocol ImageDetailViewControllerInput: AnyObject {
    func addCountImage(count: Int)
}

class ImageDetailViewController: UIViewController {

    var countImage = 0
    
    lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupLayout()
    }
    
    func setupView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height)
        layout.scrollDirection = .vertical
        
        collectionView.register(ImageDetailCell.self, forCellWithReuseIdentifier: "imageDetailCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .black
        collectionView.isPagingEnabled = true
        
        view.addSubview(collectionView)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ImageDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countImage
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: ImageDetailCell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageDetailCell", for: indexPath) as? ImageDetailCell else {
            return UICollectionViewCell()
        }
        
        cell.detailImageView.image = UIImage(named: "image_chat")
        
        return cell
    }
}

extension ImageDetailViewController: ImageDetailViewControllerInput {
    func addCountImage(count: Int) {
        self.countImage = count
    }
}
