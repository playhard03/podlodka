//
//  ViewController.swift
//  Podlodka
//
//  Created by Андрей Сергеевич on 16.03.2023.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet weak var helloLabel: UILabel!

    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let podlodka =  UserDefaults.standard.value(Podlodka.self, forKey: "name") else {return}
        
        helloLabel.text = "Привет, \(podlodka.name)"
    }
    

    @IBAction func startGameButton(){
      guard  let vc = self.storyboard?.instantiateViewController(withIdentifier: "secondViewController") as? secondViewController else {return}
        navigationController?.pushViewController(vc, animated: true)
       
    }
    
    @IBAction func settingButton(_ sender: Any) {
        guard  let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController else {return}
          navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func resultButton(_ sender: Any) {
        
        guard  let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as? ResultViewController else {return}
          navigationController?.pushViewController(vc, animated: true)
    }


}

