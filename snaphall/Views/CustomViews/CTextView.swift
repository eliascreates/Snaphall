//
//  CTextView.swift
//  snaphall
//
//  Created by IACD 013 on 2022/12/10.
//

import UIKit

extension UITextField {
    
    func configTextEdit() {
        layer.borderColor = Colors.redColor.cgColor
        textColor = .white
        tintColor = .white
        backgroundColor = Colors.redColor
        layer.cornerRadius = frame.size.height / 2
        returnKeyType = .continue
        autocorrectionType = .no
        clipsToBounds = true
        leftViewMode = .always
        
    }
    
    func leftSymbol(sysImage: String) {
        let someView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        let sideView = UIImageView(frame: CGRect(x: 30 / 2 , y: 10 / 2, width: 20, height: 20))
        
        sideView.image = UIImage(systemName: sysImage)
        sideView.contentMode = .center
        someView.addSubview(sideView)
        leftView = someView
        leftViewMode = .always
    }
    
}
