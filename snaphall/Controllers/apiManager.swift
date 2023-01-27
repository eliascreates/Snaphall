//
//  apiManager.swift
//  snaphall
//
//  Created by IACD 013 on 2023/01/27.
//

import Foundation




class ManagerAPI {
    
    let urlString = "https://api.unsplash.com/search/photos?page=1&query=office&client_id=XYj5oiG0aJa9F_3iaqjr4Y4abHgb1fHj6pUr4smEr2I"

    static let shared = ManagerAPI()
    
    
    func fetchData() {
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, respo, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            print("We have data. Yay")
        }
        task.resume()
        
        
    }
    
    
    
}


