//
//  ImageCollectionBTableViewCell.swift
//  Source
//
//  Created by JAN FREDRICK on 23/08/22.
//

import UIKit

class ImageCollectionBTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    let collectionWidth = UIScreen.main.bounds.width - 90
    
    var images: [Substring] = []
    
    var model: ItemList! {
        didSet {
            profileImage.backgroundColor = .systemBlue
            profileImage.image = UIImage(systemName: "person.circle")
            
            images = model.attachment?.split(separator: "|") ?? ["image"]
            
            imagesCollectionView.reloadData()
            
        }
    }
    
    static let identifier = "ImageCollectionBTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "ImageCollectionBTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profileImage.contentMode = .scaleAspectFill
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = 25.0
        profileImage.layer.borderWidth = 2.0
        profileImage.layer.borderColor = UIColor.gray.cgColor
        
        imagesCollectionView.backgroundColor = .darkGray
        imagesCollectionView.layer.cornerRadius = 5.0
        imagesCollectionView.layer.masksToBounds = true
        
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        
        imagesCollectionView.register(ImageCollectionViewCell.nib(), forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        
        imagesCollectionView.isScrollEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension ImageCollectionBTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count >= 4 ? 4 : images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as! ImageCollectionViewCell
        
        if indexPath.row == 3 && images.count > 4 {
            cell.showHowManyMore = images.count - 4
        }else{
            cell.showHowManyMore = 0
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        if images.count == 1 {
            let cellHeight = collectionWidth * 0.7
            
            return CGSize(width: collectionWidth, height: cellHeight)
        }
        
        let cellWidth = collectionWidth/2 - 15
        
        let cellHeight = cellWidth * 0.7
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}
