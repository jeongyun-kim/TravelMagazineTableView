//
//  FilterTableViewCell.swift
//  TableView_Travel
//
//  Created by 김정윤 on 5/31/24.
//

import UIKit

class FilterTableViewCell: UITableViewCell {
    @IBOutlet var filterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
    }

    func configureLayout() {
        filterLabel.setTitleLabel(size: 13)
        filterLabel.textAlignment = .center
    }
    
    func configureCell(_ data: String) {
        filterLabel.text = data
    }
    
}
