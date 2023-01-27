//
//  HomeViewController.swift
//  snaphall
//
//  Created by IACD 013 on 2023/01/27.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        ManagerAPI().fetchData()
    }
    
}
