//
//  ImageCollectionViewCell.swift
//  Source
//
//  Created by JAN FREDRICK on 23/08/22.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var theImageView: UIImageView!
    @IBOutlet weak var theMoreLabel: UILabel!
    
    var showHowManyMore: Int! {
        didSet {
            if showHowManyMore >= 1 {
                theMoreLabel.isHidden = false
                theMoreLabel.text = "+\(showHowManyMore ?? 1) more.."
                theMoreLabel.textAlignment = .center
                theMoreLabel.backgroundColor = UIColor.white.withAlphaComponent(0.5)
            }else{
                theMoreLabel.isHidden = true
            }
            
            theImageView.image = UIImage(systemName: "photo")
        }
    }
    
    static let identifier = "ImageCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "ImageCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

}
