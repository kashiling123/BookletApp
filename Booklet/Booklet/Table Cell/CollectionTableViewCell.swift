//
//  CollectionTableViewCell.swift
//  Booklet
//
//  Created by Mac on 08/06/22.
//

import UIKit

//typealias DidSelectClosure = ((_ tableIndex: Int?, _ collectionIndex: Int?) -> Void)

class CollectionTableViewCell: UITableViewCell {
    
    func configure(with models: [Model]) {
        self.models = models
        collectionView.reloadData()
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var models = [Model]()
    var passDataClosure: ((_ collectionIndex:Int?) -> Void)?
  //  var didSelectClosure = ((Int?, Int?) -> Void)?
    var index: Int?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension CollectionTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as? MyCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.backgroundColor = .green
        cell.configure(with: models[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 230)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        passDataClosure?(indexPath.row)
    }
    
    
}
