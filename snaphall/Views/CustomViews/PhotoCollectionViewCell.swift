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
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
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
                print("Where's the image")
            }
        }
        task.resume()
        
    }
    
}
