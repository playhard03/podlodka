//
//  PodlodkaViewController.swift
//  Podlodka
//
//  Created by Андрей Сергеевич on 17.03.2023.
//
import UIKit

class PodlodkaViewController: UIViewController {
    
    @IBOutlet weak var shipImageView: UIImageView!
    
    @IBOutlet weak var subImageView: UIImageView!
    @IBOutlet weak var sharkImageView: UIImageView!
    
    var timer : Timer?
    var scoreLabel: UILabel!
    var score = 0
    var collisionTimer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        scoreLabel = UILabel(frame: CGRect(x: 20, y: 20, width: view.frame.width - 40, height: 30))
        scoreLabel.textColor = .black
        scoreLabel.font = UIFont.systemFont(ofSize: 25)
        view.addSubview(scoreLabel)
        
        sharkMove()
        
    }
    
    @objc func sharkMove(){
        sharkImageView.frame = CGRect(x: view.frame.width - 100, y: 50, width: 50, height: 50)
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            UIView.animate(withDuration: 4) {
                self.shipImageView.frame.origin.x -= 50
            } completion: { _ in
                if self.subImageView.isIntersecting(with: self.shipImageView) {
                    self.timer?.invalidate()
                    self.gameOver()
                }
            }
        })
    }
    
    func gameOver() {
        let alert = UIAlertController(title: "Game Over", message: "Your score is \(score)", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
}
    

extension UIView {
    func isIntersecting(with view: UIView) -> Bool {
        let frame1 = self.convert(self.bounds, to: nil)
        let frame2 = view.convert(view.bounds, to: nil)
        return frame1.intersects(frame2)
    }
}
