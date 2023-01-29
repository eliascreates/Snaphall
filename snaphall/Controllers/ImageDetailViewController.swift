//
//  ImageDetailViewController.swift
//  snaphall
//
//  Created by IACD 013 on 2023/01/28.
//

import UIKit

class ImageDetailViewController: UIViewController {
    
    @IBOutlet var photoView: UIImageView!
    @IBOutlet var numberOfLikesLbl: UILabel!
    @IBOutlet var photoDescrLbl: UILabel!
    
    @IBOutlet var createdAtLbl: UILabel!
    @IBOutlet var likeButton: UIButton!
    
    var tap = false
    var selectedPhoto: Result
    
    init?(coder: NSCoder, photo: Result) {
        self.selectedPhoto = photo
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        
        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        
    }
    
    @IBAction func likePhoto(_ sender: Any) {
        
        likeButton.setImage(UIImage(systemName: tap ? "heart": "heart.fill"), for: .normal)
        tap.toggle()
    }
    func updateUI() {
        configure(imageURL: selectedPhoto.urls.regular)
        numberOfLikesLbl.text = String(selectedPhoto.likes)
        photoDescrLbl.text = selectedPhoto.description != nil ? selectedPhoto.description: selectedPhoto.altDescription
        
        //I want to convert the string date into an actual date and change it's format
        let currDate = selectedPhoto.createdAt //"2016-05-03T11:00:28-04:00" - 2016/05/03
        
//        var string = "2016-05-03T11:00:28-04:00"
        
        createdAtLbl.text = currDate
        photoView.makeRound(8)
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
                self?.photoView.image = UIImage(data: data)
            }
        }
        task.resume()
    }
}
