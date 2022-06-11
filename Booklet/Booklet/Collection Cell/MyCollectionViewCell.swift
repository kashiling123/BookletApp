//
//  MyCollectionViewCell.swift
//  Booklet
//
//  Created by Mac on 08/06/22.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(with models: Model) {
        self.titleLabel.text = models.title
        self.productImage.downloadImage(from: URL(string: models.image)!)
    }
    
    
    
}

extension UIImageView {
    
    func downloadImage(from url: URL){
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: url) { data, response, error in
            let image = UIImage(data: data!)
            DispatchQueue.main.async {
                self.image = image
            }
        }
        dataTask.resume()
    }
}
