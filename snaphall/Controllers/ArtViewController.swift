//
//  ArtViewController.swift
//  snaphall
//
//  Created by IACD 013 on 2023/01/29.
//

import UIKit

class ArtViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    var artResults: [Result] = []
    var selectedArt: Result? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        fetchData(query: "bird%20drawings")
        
        collectionView.collectionViewLayout = layout()
    }
    
    func layout() -> UICollectionViewCompositionalLayout {
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(2/3),
                heightDimension: .fractionalHeight(1)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 4.0,
                                                     leading: 4.0,
                                                     bottom: 4.0,
                                                     trailing: 4.0)
        let vertItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.5)
            )
        )
        vertItem.contentInsets = NSDirectionalEdgeInsets(top: 4.0,
                                                         leading: 4.0,
                                                         bottom: 4.0,
                                                         trailing: 4.0)
        let vertGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/3),
                heightDimension: .fractionalHeight(1)),
            repeatingSubitem: vertItem,
            count: 2
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalWidth(1)
            ),
            subitems: [
                item,
                vertGroup
            ]
        )
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    @IBSegueAction func showPhotoDetails(_ coder: NSCoder) -> ImageDetailViewController? {
        
        return ImageDetailViewController(coder: coder, photo: selectedArt!)
    }

    func fetchData(query: String? = nil) {
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
                    self?.artResults = jResults.results
                    self?.collectionView.reloadData()
                }
                
               // print("We got this!")
            } catch {
                print("Error")
                
            }
        }
        task.resume()
    }
}

extension ArtViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let url = artResults[indexPath.item].urls.regular
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoArt", for: indexPath) as? ArtPhotoCollectionViewCell {
            
            cell.configure(imageURL: url)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedArt = artResults[indexPath.item]
        
        if selectedArt != nil {
            performSegue(withIdentifier: "PhotoDetails", sender: nil)
        }
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
