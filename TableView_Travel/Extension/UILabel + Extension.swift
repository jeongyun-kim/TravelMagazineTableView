//
//  UILabel + Extension.swift
//  TableView_Travel
//
//  Created by 김정윤 on 5/27/24.
//

import UIKit

extension UILabel {
    func setTitleLabel(size: CGFloat) {
        self.font = UIFont.boldSystemFont(ofSize: size)
    }
    
    func setDescLabel(size: CGFloat = 14, color: UIColor = .lightGray) {
        self.font = UIFont.systemFont(ofSize: size)
        self.textColor = color
    }
    
    // 행간 조절
    func setLineSpacing(lineSpacing: CGFloat) {
        if let text = self.text {
            // NSMutableAttributedString : 텍스트 + 속성값을 가지는 인스턴스
            let attributedStr = NSMutableAttributedString(string: text)
            // NSMutableParagraphStyle : 텍스트에 속성을 주입해주는 인스턴스
            let style = NSMutableParagraphStyle()
            // 받아온 간격만큼 간격 주기
            style.lineSpacing = lineSpacing
            // 텍스트에 속성 추가(텍스트의 처음부터 끝까지)
            attributedStr.addAttribute(
                NSAttributedString.Key.paragraphStyle,
                value: style,
                range: NSRange(location: 0, length: attributedStr.length))
            // 속성 적용한 텍스트 주기
            self.attributedText = attributedStr
        }
    }
}

