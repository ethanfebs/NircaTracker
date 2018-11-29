//
//  SearchTableViewCell.swift
//  NircaTracker
//
//  Created by Ethan Febinger on 11/8/18.
//  Copyright © 2018 Ethan Febinger. All rights reserved.
//

import UIKit


class SearchTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var collegeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
