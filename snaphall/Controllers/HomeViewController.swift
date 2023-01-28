//
//  HomeViewController.swift
//  snaphall
//
//  Created by IACD 013 on 2023/01/27.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    var results: [Result] = []
    
    let url = "https://api.unsplash.com/search/photos?page=1&query=office&client_id=XYj5oiG0aJa9F_3iaqjr4Y4abHgb1fHj6pUr4smEr2I"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    
    }
    
    func fetchData() {
        
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
                    self?.results = jResults.results
                    self?.collectionView.reloadData()
                    print("We got It")
                }
                
            } catch {
                print("Error")
                
            }
        }
        task.resume()
    }
    
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        results.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let url = results[indexPath.row].urls.regular
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(imageURL: url)
        
        
        return cell
    }
    
}
