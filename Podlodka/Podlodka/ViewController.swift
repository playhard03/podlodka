//
//  ViewController.swift
//  Podlodka
//
//  Created by Андрей Сергеевич on 16.03.2023.
//

import UIKit

class ViewController: UIViewController {

   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func startGameButton(){
      guard  let vc = self.storyboard?.instantiateViewController(withIdentifier: "mainViewController") as? mainViewController else {return}
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

