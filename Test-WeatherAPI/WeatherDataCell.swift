//
//  WeatherDataCell.swift
//  Test-WeatherAPI
//
//  Created by rahul mahajan on 18/05/18.
//  Copyright © 2018 rahul mahajan. All rights reserved.
//

import UIKit

class WeatherDataCell: UITableViewCell {

    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
