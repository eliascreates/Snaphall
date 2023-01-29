//
//  HomeViewController.swift
//  snaphall
//
//  Created by IACD 013 on 2023/01/27.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var recentPhotosCollectionView: UICollectionView!
    
    var results: [Result] = []
    var photoResults: [Result] = []
    var selectedPhoto: Result? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData(query: "office", sender: "First")
        fetchData(query: "drawings", sender: "Second")
        
        
        recentPhotosCollectionView.delegate = self
        recentPhotosCollectionView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    func fetchData(query: String? = nil, sender: String) {
        
        var url = "https://api.unsplash.com/search/photos?page=1&query=drawings&client_id=XYj5oiG0aJa9F_3iaqjr4Y4abHgb1fHj6pUr4smEr2I"
        
        if let query = query, query.firstIndex(of: " ") == nil {
            
            url = "https://api.unsplash.com/search/photos?page=1&query=\(query)&client_id=XYj5oiG0aJa9F_3iaqjr4Y4abHgb1fHj6pUr4smEr2I"
        }
        
        guard let url = URL(string: url) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, respo, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let jResults = try JSONDecoder().decode(Response.self, from: data)
                
                DispatchQueue.main.async {
                    
    
                    print("Something happend")
                    if sender == "First" {
                        self?.results = jResults.results
                        self?.collectionView.reloadData()
                    } else if sender == "Second" {
                        self?.photoResults = jResults.results
                        self?.recentPhotosCollectionView.reloadData()
                    }
                }
                
                print("We got this!")
            } catch {
                print("Error")
                
            }
        }
        task.resume()
    }
    
    
    @IBSegueAction func showPhotoDetails(_ coder: NSCoder) -> ImageDetailViewController? {
        
        return ImageDetailViewController(coder: coder, photo: selectedPhoto!)
    }
    
}

// MARK: Collection View
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            
            return results.count
        } else if collectionView == self.recentPhotosCollectionView {
            return photoResults.count
        }
        return 0
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == self.collectionView {
            return 1
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionView {
            
            let url = results[indexPath.row].urls.regular
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.configure(imageURL: url)
            
            return cell
        } else if collectionView == self.recentPhotosCollectionView {
            
            let url = photoResults[indexPath.row].urls.regular
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentPhoto", for: indexPath) as? RecentPhotoCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.configure(imageURL: url)
            
            return cell
        }
        
        
        
        
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.collectionView {
            selectedPhoto = results[indexPath.row]
            
        } else if collectionView == recentPhotosCollectionView {
            selectedPhoto = photoResults[indexPath.row]
            
        }
        
        if selectedPhoto != nil {
            performSegue(withIdentifier: "PhotoDetails", sender: nil)
        }
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
    
}
