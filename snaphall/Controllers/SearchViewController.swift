//
//  SearchViewController.swift
//  snaphall
//
//  Created by IACD 013 on 2023/01/27.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var collectionView: UICollectionView!
    
    var searchResults: [Result] = []
    var selectedPhoto: Result? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        fetchData(query: "Coding")
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
                    self?.searchResults = jResults.results
                    self?.collectionView.reloadData()
                }
                
               // print("We got this!")
            } catch {
                print("Error")
                
            }
        }
        task.resume()
    }
    
    @IBSegueAction func showPhotoDetails(_ coder: NSCoder) -> ImageDetailViewController? {
        
        return ImageDetailViewController(coder: coder, photo: selectedPhoto!)
    }
    
    @IBAction func unwindToSearch(unwind: UIStoryboardSegue) {
        
        
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != nil {
            searchResults = []
            fetchData(query: searchBar.text)
        }
        searchBar.resignFirstResponder()
    }
    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let url = searchResults[indexPath.row].urls.regular
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchPhoto", for: indexPath) as? SearchCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(imageURL: url)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedPhoto = searchResults[indexPath.row]
        
        if selectedPhoto != nil {
            performSegue(withIdentifier: "PhotoDetails", sender: nil)
        }
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
