//
//  UIColor + Extension.swift
//  TableView_Travel
//
//  Created by 김정윤 on 6/3/24.
//

import UIKit

extension UIColor {
    static func getRandomColor() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0).withAlphaComponent(1)
        return color
    }
}
