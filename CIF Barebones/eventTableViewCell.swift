//
//  eventTableViewCell.swift
//  CIF Barebones
//
//  Created by Connor Wybranowski on 5/31/15.
//  Copyright (c) 2015 Wybro. All rights reserved.
//

import UIKit

class eventTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var titleOfEvent: UILabel!
    @IBOutlet weak var locationOfEvent: UILabel!
    @IBOutlet weak var distanceFromLocation: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
   
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
