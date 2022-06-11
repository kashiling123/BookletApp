//
//  MyTableViewCell.swift
//  Booklet
//
//  Created by Mac on 09/06/22.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    
    
    
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var bookImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        bookImage.layer.cornerRadius = bookImage.frame.size.width / 2
        bookImage.clipsToBounds = true
        bookImage.layer.borderColor = UIColor.blue.cgColor
        
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
