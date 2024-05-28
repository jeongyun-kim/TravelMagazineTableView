//
//  UITableCell + Extension.swift
//  TableView_Travel
//
//  Created by 김정윤 on 5/27/24.
//

import UIKit

extension UITableViewCell {
    // 구분선 숨기기
    func hideSeparator() {
        self.separatorInset = UIEdgeInsets(top: 0, left: self.bounds.size.width, bottom: 0, right: 0)
    }
    // 구분선 보여주기
    func showSeparator() {
        self.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
