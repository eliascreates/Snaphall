//
//  CButton.swift
//  snaphall
//
//  Created by IACD 013 on 2022/12/10.
//

import UIKit

class CButton: UIButton
{

    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        configButton()
    }
    
    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)
        configButton()
    }
    
    
    func configButton()
    {
        setTitle("Sign In", for: .normal)
        setTitleColor(Colors.redColor, for: .normal)
        backgroundColor = Colors.darkColor
        titleLabel?.font = UIFont(name: Font.noteFont, size: 20)
        layer.cornerRadius = frame.size.height / 2
    }
    
    
}
