import UIKit

class mainViewController: UIViewController {
    var submarine = UIImageView()
    var timer = Timer()
    var fishes = [UIImageView]()
    var scoreLabel = UILabel()
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add the background image
        let background = UIImageView(image: UIImage(named: ""))
        background.frame = view.bounds
        background.contentMode = .scaleAspectFill
        view.addSubview(background)
        
        // Add the score label
        scoreLabel.frame = CGRect(x: 20, y: 20, width: view.frame.width - 40, height: 30)
        scoreLabel.textColor = .black
        scoreLabel.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(scoreLabel)
        
        // Add the submarine image
        submarine = UIImageView(image: UIImage(named: "submarine"))
        submarine.frame = CGRect(x: view.frame.width/2 - 325, y: view.frame.height - 100, width: 50, height: 50)
        view.addSubview(submarine)
        
        // Start the game timer
        timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(addFish), userInfo: nil, repeats: true)
    }
    
    @objc func addFish() {
        // Add a new fish image
        let fish = UIImageView(image: UIImage(named: "fish"))
        fish.frame = CGRect(x: view.frame.width, y: CGFloat.random(in: 0..<view.frame.height - 50), width: 50, height: 50)
        view.addSubview(fish)
        fishes.append(fish)
        
        // Animate the fish movement
        UIView.animate(withDuration: 3.0, delay: 0, options: .curveLinear, animations: {
            fish.frame.origin.x = -50
        }, completion: { (finished) in
            fish.removeFromSuperview()
            self.fishes = self.fishes.filter { $0 != fish }
        })
        
        // Check for collisions with the new fish
        let fishFrame = view.convert(fish.frame, to: nil)
        let submarineFrame = view.convert(submarine.frame, to: nil)
        if fishFrame.intersects(submarineFrame) {
            gameOver()
        }
    }

    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Move the submarine with touch
        if let touch = touches.first {
            let location = touch.location(in: view)
            submarine.frame.origin.y = location.y - 25
        }
    }
    
    func gameOver() {
        // Stop the game timer
        timer.invalidate()
        
        // Show the game over alert
        let alert = UIAlertController(title: "Game Over", message: "Your score is \(score)", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Update the score
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
}
