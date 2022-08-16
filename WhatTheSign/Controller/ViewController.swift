//
//  ViewController.swift
//  WhatTheSign
//
//  Created by Илья Валито on 15.08.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var signsArray = [[String: String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "Signs", ofType: "plist")!
        guard let data = NSArray(contentsOfFile: path) as? Array<[String: String]> else { return }
        signsArray = data
        print(signsArray)
       
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        signsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "signCell", for: indexPath) as! SignTableViewCell
        
        cell.signNumber.text = signsArray[indexPath.row]["signNumber"]
        cell.signName.text = signsArray[indexPath.row]["signName"]
        cell.signImage.image = UIImage(named: signsArray[indexPath.row]["signNumber"] ?? "1.1")
        
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
}

