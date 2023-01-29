//
//  Constants.swift
//  snaphall
//
//  Created by IACD 013 on 2022/12/10.
//

import UIKit

struct Colors {
    static let darkColor: UIColor = UIColor(red: 22/255, green: 33/255, blue: 62/255, alpha: 1)
    static let redColor: UIColor = UIColor(red: 233/255, green: 69/255, blue: 96/255, alpha: 1)
    static let navyColor: UIColor = UIColor(red: 15/255, green: 52/255, blue: 96/255, alpha: 1)
    static let purpleColor: UIColor = UIColor(red: 83/255, green: 52/255, blue: 131/255, alpha: 1)
}

struct Font {
    static let noteFoont = "Noteworthy"
    static let americanTypewrite = "American Typewriter"
}

extension UIView {
    func makeRound(_ radius: CGFloat? = nil) {
        if let radius = radius {
            layer.cornerRadius = radius
        } else {
            layer.cornerRadius = frame.size.height / 2
        }
        layer.masksToBounds = true
    }
}

extension Date {
    var wordForm: String {
        self.formatted(.dateTime
            .month(.abbreviated)
            .day(.twoDigits)
            .year().minute(.twoDigits).hour(.conversationalDefaultDigits(amPM: .abbreviated)))
    }
}
