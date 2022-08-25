//
//  DetailsViewController.swift
//  WhatTheSign
//
//  Created by Илья Валито on 24.08.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var imageData: UIImage!
    var infoData: String!
    var nameData: String!
    var numberData: String!
    
    @IBOutlet weak var signImage: UIImageView!
    @IBOutlet weak var signName: UILabel!
    @IBOutlet weak var signInfo: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signImage.image = imageData
        signInfo.text = infoData
        signName.text = nameData
        
        signImage.layer.cornerRadius = signImage.bounds.height / 25
        signImage.layer.borderWidth = 1.5
        signImage.layer.borderColor = UIColor.black.cgColor
        
        signInfo.layer.cornerRadius = signInfo.bounds.height / 25
        signInfo.layer.borderWidth = 1.5
        signInfo.layer.borderColor = UIColor.black.cgColor
        
        let label = UILabel()
            label.backgroundColor = .clear
            label.numberOfLines = 2
            label.font = UIFont(name: "system", size: 17)
            label.textAlignment = .center
            label.textColor = .systemYellow
            label.text = numberData
            self.navigationItem.titleView = label
    }
    @IBAction func webSearchTapped(_ sender: UIBarButtonItem) {
        guard let url = URL(string: "http://www.google.com/search?q=%D0%B7%D0%BD%D0%B0%D0%BA%20%D0%BF%D0%B4%D0%B4%20%0A\(numberData!)") else {
          return
        }

        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
