//
//  MessageTableViewCell.swift
//  Source
//
//  Created by JAN FREDRICK on 23/08/22.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImgae: UIImageView!
    @IBOutlet weak var messageLabel: PaddingLabel!
    @IBOutlet weak var attachmentImage: UIImageView!
    
    static let identifier = "MessageTableViewCell"
    
    var model: ItemList! {
        didSet {
            profileImgae.backgroundColor = .systemRed
            profileImgae.image = UIImage(systemName: "person.circle")
            
            if model.attachment == nil {
                messageLabel.text = model.body
                
                messageLabel.leftInset = 7.0
                attachmentImage.isHidden = true
            }else{
                if model.attachment == "document" {
                    messageLabel.text = "This is a document"
                    attachmentImage.image = UIImage(systemName: "doc")
                }else{
                    
                    if model.attachment!.split(separator: "|").count > 1 {
                        messageLabel.text = "There is more than one contact"
                        attachmentImage.image = UIImage(systemName: "person.2")
                    }else{
                        messageLabel.text = "This is a contact"
                        attachmentImage.image = UIImage(systemName: "person")
                    }
                    
                }
                
                messageLabel.leftInset = 40.0
                attachmentImage.isHidden = false
            }
        }
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "MessageTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profileImgae.contentMode = .scaleAspectFill
        profileImgae.layer.masksToBounds = true
        profileImgae.layer.cornerRadius = 25.0
        profileImgae.layer.borderWidth = 2.0
        profileImgae.layer.borderColor = UIColor.gray.cgColor
        
        messageLabel.backgroundColor = .darkGray
        messageLabel.textColor = .white
        messageLabel.layer.masksToBounds = true
        messageLabel.layer.cornerRadius = 5.0
        messageLabel.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

class PaddingLabel: UILabel {

    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 7.0
    @IBInspectable var rightInset: CGFloat = 7.0

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }

    override var bounds: CGRect {
        didSet {
            // ensures this works within stack views if multi-line
            preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset)
        }
    }
}
