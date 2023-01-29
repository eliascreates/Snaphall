//
//  PhotoCollectionViewCell.swift
//  snaphall
//
//  Created by IACD 013 on 2023/01/27.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var imageView: UIImageView!
        
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.makeRound(8)
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.systemGray.cgColor
    }
    
    
    func configure(imageURL: String) {
        guard let url = URL(string: imageURL) else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.imageView.image = UIImage(data: data)
            }
        }
        task.resume()
        
    }
    
}
