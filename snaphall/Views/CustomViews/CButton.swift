//
//  CButton.swift
//  snaphall
//
//  Created by IACD 013 on 2022/12/10.
//

import UIKit

class CButton: UIButton {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func configButton(title: String, for state: UIControl.State) {
        setTitle(title, for: state)
        setTitleColor(Colors.redColor, for: .normal)
        backgroundColor = Colors.darkColor
        titleLabel?.font = UIFont(name: Font.noteFont, size: 20)
    }
    
    func makeRound(_ radius: CGFloat? = nil) {
        if let radius = radius {
            layer.cornerRadius = radius
        } else {
            layer.cornerRadius = frame.size.height / 2
        }
    }
}
