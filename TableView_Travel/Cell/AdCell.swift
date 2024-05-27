//
//  AdCell.swift
//  TableView_Travel
//
//  Created by 김정윤 on 5/27/24.
//

import UIKit

class AdCell: UITableViewCell {
    @IBOutlet var adView: UIView!
    @IBOutlet var adLabel: UILabel!
    @IBOutlet var adBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
    }

    func configureLayout() {
        adView.backgroundColor = getRandomColor()
        adView.layer.cornerRadius = 10
        
        adLabel.setLabelDesign(bold: true, size: 15, color: .black)
        
        adLabel.numberOfLines = 0
        adLabel.setLineSpacing(lineSpacing: 4)
        adLabel.textAlignment = .center
        
        adBtn.setTitle("AD", for: .normal)
        adBtn.titleLabel?.setLabelDesign(size: 12)
        adBtn.tintColor = .black
        adBtn.backgroundColor = .white
        adBtn.layer.cornerRadius = 8
    }
    
    func configureCell(title: String) {
        adLabel.text = title
    }
    
    func getRandomColor() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0).withAlphaComponent(0.5)
        return color
    }
}
