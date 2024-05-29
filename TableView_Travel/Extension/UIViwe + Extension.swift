//
//  UIViwe + Extension.swift
//  TableView_Travel
//
//  Created by 김정윤 on 5/29/24.
//

import UIKit

extension UIView {
    func setMaskedCorner(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = maskedCorners
        self.layer.masksToBounds = true
    }
}
