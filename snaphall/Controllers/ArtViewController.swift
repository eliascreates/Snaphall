//
//  ArtViewController.swift
//  snaphall
//
//  Created by IACD 013 on 2023/01/29.
//

import UIKit

class ArtViewController: UIViewController {

    
    @IBOutlet var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
 
        
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
    

}

extension ArtViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoArt", for: indexPath) as? ArtPhotoCollectionViewCell {
            
            return cell
        }
        return UICollectionViewCell()
    }
    
}
