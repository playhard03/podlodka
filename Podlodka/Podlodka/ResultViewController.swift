//
//  ResultViewController.swift
//  Podlodka
//
//  Created by Андрей Сергеевич on 16.03.2023.
//

import UIKit

class ResultViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


    @IBAction func backButton(_ sender: Any) {
        
        navigationController?.popToRootViewController(animated: true)
    }
}
