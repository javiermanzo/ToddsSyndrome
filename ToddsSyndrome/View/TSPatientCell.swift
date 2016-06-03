//
//  TSPatientCell.swift
//  ToddsSyndrome
//
//  Created by Javier Roberto Manzo on 6/1/16.
//  Copyright © 2016 Javier Roberto Manzo. All rights reserved.
//

import UIKit

class TSPatientCell: UITableViewCell {
    
    @IBOutlet weak var nameAndAgeLabel: UILabel!
    @IBOutlet weak var consumeDrugsLabel: UILabel!
    @IBOutlet weak var migranesLabel: UILabel!
    @IBOutlet weak var percentageProbabilityLabel: UILabel!
    @IBOutlet weak var genderImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
