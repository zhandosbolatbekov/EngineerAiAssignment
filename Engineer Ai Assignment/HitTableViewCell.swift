//
//  HitTableViewCell.swift
//  Engineer Ai Assignment
//
//  Created by Zhandos Bolatbekov on 12/18/18.
//  Copyright © 2018 zhandos. All rights reserved.
//

import UIKit

class HitTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var createdAtLabel: UILabel!
    
    var hit: Hit? {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updateUI()
    }

    private func updateUI() {
        guard let hit = hit else {
            return
        }
        titleLabel.text = hit.title
        createdAtLabel.text = formattedDateString(from: hit.createdAt)
    }
    
    private func formattedDateString(from string: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sssZ"
        let date = formatter.date(from: string)!
        
        formatter.dateFormat = "MMM dd, yyyy, H:mm (z)"
        return formatter.string(from: date)
    }
}
