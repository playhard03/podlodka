//
//  SettingsViewController.swift
//  Podlodka
//
//  Created by Андрей Сергеевич on 16.03.2023.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var textNameLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let podlodka =  UserDefaults.standard.value(Podlodka.self, forKey: "name") else {return}
        textNameLabel.text = podlodka.name
        segment.selectedSegmentIndex = podlodka.image 
    }
    


    @IBAction func backButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
 
    
    @IBAction func saveButton(_ sender: Any) {
        textNameLabel.text = textField.text
        textField.text = nil
        let podlodka = Podlodka(name: textNameLabel.text!, image: segment.selectedSegmentIndex, score: 1, date: "Today")
        UserDefaults.standard.setValue(encodable: podlodka, forKey: "name")
        UserDefaults.standard.setValue(encodable: podlodka, forKey: "image")
    }
    

 
}
