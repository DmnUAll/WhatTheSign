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
        
        signImage.layer.cornerRadius = signImage.bounds.size.height / 5
        signImage.layer.borderWidth = 1.5
        signImage.layer.borderColor = UIColor.black.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
