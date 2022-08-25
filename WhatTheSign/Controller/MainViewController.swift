//
//  ViewController.swift
//  WhatTheSign
//
//  Created by Илья Валито on 15.08.2022.
//

import UIKit
import CoreML
import Vision

class MainViewController: UIViewController {
    
    let imagePicker = UIImagePickerController()
    var signsArray = [[String: String]]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        
        let path = Bundle.main.path(forResource: "Signs", ofType: "plist")!
        guard let data = NSArray(contentsOfFile: path) as? Array<[String: String]> else { return }
        signsArray = data
        //print(signsArray)
    }
    
    @IBAction func infoTapped(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Ссылка на GitHub", message: nil, preferredStyle: .alert)
        let textView = UITextView()
        textView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        let controller = UIViewController()

        textView.frame = controller.view.frame
        controller.view.addSubview(textView)
        textView.backgroundColor = .clear

        alert.setValue(controller, forKey: "contentViewController")

        let height: NSLayoutConstraint = NSLayoutConstraint(item: alert.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 150)
        alert.view.addConstraint(height)

        let attributedString = NSMutableAttributedString(string: "https://github.com/DmnUAll/WhatTheSign")
        let url = URL(string: "https://github.com/DmnUAll/WhatTheSign")

        attributedString.setAttributes([.link: url ?? ""], range: NSMakeRange(0, attributedString.length))


        textView.attributedText = attributedString
        textView.isUserInteractionEnabled = true
        textView.isEditable = false
        textView.textAlignment = .center

        textView.linkTextAttributes = [
            .foregroundColor: UIColor.white,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]

        let okAction = UIAlertAction(title: "OK", style: .default) {
            UIAlertAction in
        }

        alert.addAction(okAction)

        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toDetails":
            guard let destinationVC = segue.destination as? DetailsViewController else { return }
            let indexPath = tableView.indexPathForSelectedRow
            let signsArray = signsArray.filter{$0["signNumber"]!.hasPrefix("\(indexPath!.section + 1)")}
            destinationVC.infoData = signsArray[indexPath!.row]["signDescription"]
            destinationVC.imageData = UIImage(named: signsArray[indexPath!.row]["signNumber"] ?? "1.1")
            destinationVC.nameData = signsArray[indexPath!.row]["signName"]
            destinationVC.numberData = signsArray[indexPath!.row]["signNumber"]
            tableView.deselectRow(at: indexPath!, animated: true)
        case "toDetailsByPhoto":
            guard let destinationVC = segue.destination as? DetailsViewController else { return }
            destinationVC.infoData = Sign.guessedSign?["signDescription"] ?? "Не определено"
            destinationVC.imageData = UIImage(named: Sign.guessedSign?["signNumber"] ?? "1.1")
            destinationVC.nameData = Sign.guessedSign?["signName"] ?? "Не определено"
            destinationVC.numberData = Sign.guessedSign?["signNumber"] ?? "Не определено"
        default: return
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Sign.signCategory.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Sign.signCategory[section]
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 48)
        myLabel.font = UIFont.boldSystemFont(ofSize: 17)
        myLabel.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        myLabel.textAlignment = .center
        myLabel.numberOfLines = 2
        
        let headerView = UIView()
        headerView.addSubview(myLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return 48
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var counter = 0
        for item in signsArray where item["signNumber"]!.hasPrefix("\(section + 1)") {
            counter += 1
        }
        return counter
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let signsArray = signsArray.filter{$0["signNumber"]!.hasPrefix("\(indexPath.section + 1)")}
        let cell = tableView.dequeueReusableCell(withIdentifier: "signCell", for: indexPath) as! SignTableViewCell
        
        cell.signNumber.text = signsArray[indexPath.row]["signNumber"]
        cell.signName.text = signsArray[indexPath.row]["signName"]
        cell.signImage.image = UIImage(named: signsArray[indexPath.row]["signNumber"] ?? "1.1")
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetails", sender: nil)
    }
}

extension MainViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            guard let ciimage = CIImage(image: userPickedImage) else {
                fatalError("Не удалось конвертировать UIImage в CIImage")
            }
              detectImage(image: ciimage)
        }
        imagePicker.dismiss(animated: true)
    }
    
    func detectImage(image: CIImage) {
        guard let model = try? VNCoreMLModel(for: RoadSignImageClassifier(configuration: MLModelConfiguration()).model) else {
            fatalError("Ошибка загрузки модели CoreML")
        }
        
        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Ошибка при обработке фото")
            }
            //print(results)
            
            if let firstResult = results.first {
                Sign.guessedSign = self.signsArray.first(where: {$0["signNumber"] == firstResult.identifier})
                self.performSegue(withIdentifier: "toDetailsByPhoto", sender: nil)
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        } catch {
            fatalError("Ошибка при обработке запроса")
        }
    }
}

extension MainViewController: UINavigationControllerDelegate {
    
}
