import UIKit

class secondViewController: UIViewController {
    
    var submarineImageView: UIImageView!
    var fishImageViews: [UIImageView] = []
    var timer: Timer?
    var score = 0
    var scoreLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let podlodka =  UserDefaults.standard.value(Podlodka.self, forKey: "name") else {return}
      
        
        // Создаем изображение субмарины и размещаем его на левой стороне экрана
        createSub()

        // Создаем три рыбы и размещаем их на правой стороне экрана
        createFish()
        
        // Создаем метку для отображения счета игры
        scoreLabel = UILabel(frame: CGRect(x: view.frame.width / 2 - 170, y: 30, width: 300, height: 50))
        scoreLabel.textAlignment = .center
        scoreLabel.text = "\(podlodka.name) Score: 0"
        view.addSubview(scoreLabel)
        
        // Запускаем игровой таймер
        startTimer()
    }
    
    func createFish() {
        for _ in 1...4 { // создаем 3 рыбы
            let fishImageView = UIImageView(image: UIImage(named: "fish"))
            let fishSize = CGSize(width: 50, height: 50)
            let randomY = CGFloat.random(in: fishSize.height..<view.frame.height - fishSize.height)
            fishImageView.frame = CGRect(origin: CGPoint(x: view.frame.width - fishSize.width, y: randomY), size: fishSize)
            view.addSubview(fishImageView)
            fishImageViews.append(fishImageView)
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] _ in
            self?.moveFish()
        }
    }
    
    func moveFish() {
        guard let podlodka =  UserDefaults.standard.value(Podlodka.self, forKey: "name") else {return}
        for fishImageView in fishImageViews {
            // Перемещаем рыбу слева направо
            fishImageView.frame.origin.x -= 7
            
            // Если рыба вышла за пределы экрана, перемещаем ее на правую сторону
            if fishImageView.frame.maxX < 0 {
                let fishSize = CGSize(width: 50, height: 50)
                let randomY = CGFloat.random(in: fishSize.height..<view.frame.height - fishSize.height)
                fishImageView.frame = CGRect(origin: CGPoint(x: view.frame.width - fishSize.width, y: randomY), size: fishSize)
            }
            
            // Если рыба столкнулась с субмариной, увеличиваем счет и перемещаем ее на правую сторону экрана
            if fishImageView.frame.intersects(submarineImageView.frame) {
                score += 1
                scoreLabel.text = "\(podlodka.name) Score: \(score)"
                let fishSize = CGSize(width: 50, height: 50)
                let randomY = CGFloat.random(in: fishSize.height..<view.frame.height - fishSize.height)
                fishImageView.frame = CGRect(origin: CGPoint(x: view.frame.width - fishSize.width, y: randomY), size: fishSize)
            }
        }
        endGame()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Если нажата кнопка вверх, перемещаем субмарину вверх на 10 пикселей
        if let touch = touches.first {
            let touchLocation = touch.location(in: view)
            if touchLocation.y < submarineImageView.frame.midY {
                submarineImageView.frame.origin.y -= 15
            }
            // Если нажата кнопка вниз, перемещаем субмарину вниз на 10 пикселей
            else {
                submarineImageView.frame.origin.y += 15
            }
        }
    }
    
    private func createSub(){
        // Создаем изображение субмарины и размещаем его на левой стороне экрана
        guard let podlodka =  UserDefaults.standard.value(Podlodka.self, forKey: "name") else {return}
        if podlodka.image == 1 {
            let submarineImage = UIImage(named: "submarine")
            let submarineSize = CGSize(width: 100, height: 50)
            submarineImageView = UIImageView(image: submarineImage)
            submarineImageView.frame = CGRect(origin: CGPoint(x: 80, y: view.frame.height / 2 - submarineSize.height / 2), size: submarineSize)
            view.addSubview(submarineImageView)
        } else {
            let submarineImage = UIImage(named: "submarine2")
            let submarineSize = CGSize(width: 100, height: 50)
            submarineImageView = UIImageView(image: submarineImage)
            submarineImageView.frame = CGRect(origin: CGPoint(x: 80, y: view.frame.height / 2 - submarineSize.height / 2), size: submarineSize)
            view.addSubview(submarineImageView)
        }
    }
    
    private func endGame(){
        if score >= 7 {
            timer?.invalidate()
            let score = Podlodka(score: score)
            UserDefaults.standard.setValue(encodable: score, forKey: "score")
            
            let alert = UIAlertController(title: "Game Over", message: "Игра закончена", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default) { _ in
                self.navigationController?.popToRootViewController(animated: true)
            }
            alert.addAction(ok)
            present(alert, animated: true)
        }
        
    }
}
