//
//  MessageBTableViewCell.swift
//  Source
//
//  Created by JAN FREDRICK on 23/08/22.
//

import UIKit

class MessageBTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var messageLabel: PaddingLabel!
    @IBOutlet weak var attachmentImage: UIImageView!
    
    static let identifier = "MessageBTableViewCell"
    
    var model: ItemList! {
        didSet {
            profileImage.backgroundColor = .systemBlue
            profileImage.image = UIImage(systemName: "person.circle")
            
            if model.attachment == nil {
                messageLabel.text = model.body
                
                messageLabel.rightInset = 7.0
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
                
                messageLabel.rightInset = 40.0
                attachmentImage.isHidden = false
            }
            
        }
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "MessageBTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profileImage.contentMode = .scaleAspectFill
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = 25.0
        profileImage.layer.borderWidth = 2.0
        profileImage.layer.borderColor = UIColor.gray.cgColor
        
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
