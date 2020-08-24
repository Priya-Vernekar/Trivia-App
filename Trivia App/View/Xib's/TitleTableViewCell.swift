//
//  TitleTableViewCell.swift
//  Trivia App
//
//  Created by Priya Vernekar on 24/08/20.
//  Copyright © 2020 Priya Vernekar. All rights reserved.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
