//
//  SignTableViewCell.swift
//  WhatTheSign
//
//  Created by Илья Валито on 16.08.2022.
//

import UIKit

class SignTableViewCell: UITableViewCell {

    @IBOutlet weak var signNumber: UILabel!
    @IBOutlet weak var signName: UILabel!
    @IBOutlet weak var signImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
