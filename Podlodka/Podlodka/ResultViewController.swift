//
//  ResultViewController.swift
//  Podlodka
//
//  Created by Андрей Сергеевич on 16.03.2023.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var recordLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let podlodka =  UserDefaults.standard.value(Podlodka.self, forKey: "score") else {return}
        recordLabel.text = "Ваш рекорд - \(podlodka.score)"
        timeLabel.text = "Последний заплыв: - \(podlodka.date)"
    }
    


    @IBAction func backButton(_ sender: Any) {
        
        navigationController?.popToRootViewController(animated: true)
    }
}
