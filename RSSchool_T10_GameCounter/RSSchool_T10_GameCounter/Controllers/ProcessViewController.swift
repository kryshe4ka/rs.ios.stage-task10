//
//  ProcessViewController.swift
//  RSSchool_T10_GameCounter
//
//  Created by Liza Kryshkovskaya on 25.08.21.
//

import UIKit

protocol NewGameViewControllerDelegate {
    func setPlayers(players: [Player])
    func startTimer()
    func clearTimer()
}

struct HistoryData {
    let player: Player?
    let playerIndex: Int
    let points: Int
}

class ProcessViewController: UIViewController, NewGameViewControllerDelegate {
    
    var playersArray: [Player] = []
    var history: [HistoryData] = []
    
    private var isGameActive = false
    private var gameTimer: Timer?
    private var gameTimePassed: Int = 0
    
    func clearTimer() {
        gameTimePassed = 0
    }
    @objc func startTimer() {
        // before start new timer stop the last timer
        gameTimer?.invalidate()
        // create timer
        gameTimer = Timer.scheduledTimer(timeInterval: 1,
                                         target: self,
                                         selector: #selector(updateTimer(_:)),
                                         userInfo: nil,
                                         repeats: true
        )
        isGameActive = true
        updateUI()
    }
    
    private func updateUI() {
        // if game ia active hide start button and show pause button
        timerPlayButton.isHidden = isGameActive
        timerPauseButton.isHidden = !isGameActive
        
        let minutes = (gameTimePassed / 60) < 10 ? "0\(gameTimePassed / 60)" : "\(gameTimePassed / 60)"
        
        let seconds = (gameTimePassed - 60 * (gameTimePassed / 60)) < 10 ? "0\(gameTimePassed - 60 * (gameTimePassed / 60))" : "\(gameTimePassed - 60 * (gameTimePassed / 60))"
        if isGameActive {
            timerLabel.text = "\(minutes):\(seconds)"
            timerLabel.textColor = .white
        } else {
            timerLabel.text = "\(minutes):\(seconds)"
            timerLabel.textColor = UIColor(named: "CustomGray")
        }
    }
    
    @objc func updateTimer(_ sender: Timer) {
        gameTimePassed += 1
        updateUI()
    }
    
    @objc private func stopGame() {
        isGameActive = false
        updateUI()
        // stop timer
        gameTimer?.invalidate()
    }
    
    private lazy var newGameButton: ActionButton = {
        let button = ActionButton()
        button.setTitle("New Game", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(newGameAction(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var resultsButton: ActionButton = {
        let button = ActionButton()
        button.setTitle("Results", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(resultsAction(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: TitleLabel = {
        let label = TitleLabel()
        label.text = "Game"
        return label
    }()
    
    private lazy var diceButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "icon_Dice"), for: .normal)
        button.addTarget(self, action: #selector(diceAction(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00"
        label.font = UIFont(name: "Nunito-ExtraBold", size: 28)
        label.textColor = UIColor(named: "CustomGray")
        return label
    }()
    
    private lazy var timerPlayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Play"), for: .normal)
        button.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        return button
    }()
    private lazy var timerPauseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Pause"), for: .normal)
        button.isHidden = true
        button.addTarget(self, action: #selector(stopGame), for: .touchUpInside)
        return button
    }()
    
    private lazy var undoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Undo"), for: .normal)
        button.addTarget(self, action: #selector(undo(_:)), for: .touchUpInside)
        return button
    }()
    
    @objc func undo(_ sender: UIButton) {
        if history.count > 0 {
            guard let lastAction = history.popLast() else {
                return
            }
            playersArray[lastAction.playerIndex].score -= lastAction.points
            print(lastAction.playerIndex)
            print(playersArray[lastAction.playerIndex].score)
            carouselView!.changePoints(player: lastAction.playerIndex, points: playersArray[lastAction.playerIndex].score)
        }
    }
    
    private lazy var plusOnePointButton: PointButton = {
        let button = PointButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 40)
        button.layer.cornerRadius = 45
        button.setTitle("+1", for: .normal)
        button.tag = 1
        button.addTarget(self, action: #selector(changePoints(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var previousButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "icon_Next-2"), for: .normal)
        button.tintColor = UIColor(named: "CustomOrange")
        button.addTarget(self, action: #selector(previousPage(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "icon_Next"), for: .normal)
        button.tintColor = UIColor(named: "CustomOrange")
        button.addTarget(self, action: #selector(nextPage(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var pointsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var plusFivePointButton: PointButton = {
        let button = PointButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 25)
        button.layer.cornerRadius = 27.5
        button.setTitle("+5", for: .normal)
        button.tag = 5
        button.addTarget(self, action: #selector(changePoints(_:)), for: .touchUpInside)
        return button
    }()
    private lazy var plusTenPointButton: PointButton = {
        let button = PointButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 25)
        button.layer.cornerRadius = 27.5
        button.setTitle("+10", for: .normal)
        button.tag = 10
        button.addTarget(self, action: #selector(changePoints(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var minusFivePointButton: PointButton = {
        let button = PointButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 25)
        button.layer.cornerRadius = 27.5
        button.setTitle("-5", for: .normal)
        button.tag = -5
        button.addTarget(self, action: #selector(changePoints(_:)), for: .touchUpInside)
        return button
    }()
    private lazy var minusOnePointButton: PointButton = {
        let button = PointButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 25)
        button.layer.cornerRadius = 27.5
        button.setTitle("-1", for: .normal)
        button.tag = -1
        button.addTarget(self, action: #selector(changePoints(_:)), for: .touchUpInside)
        return button
    }()
    private lazy var minusTenPointButton: PointButton = {
        let button = PointButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 25)
        button.layer.cornerRadius = 27.5
        button.setTitle("-10", for: .normal)
        button.tag = -10
        button.addTarget(self, action: #selector(changePoints(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var diceView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var newGameViewConroller: NewGameViewController = {
        let controller = NewGameViewController()
        return controller
    }()
    
    private lazy var resultsViewConroller: ResultsViewConroller = {
        let controller = ResultsViewConroller()
        return controller
    }()

    private var carouselView:  CarouselView?
    private var carouselData = [CarouselView.CarouselData]()
    
    @objc func changePoints(_ sender: PointButton) {
        if playersArray.count != 0 {
            guard let curentPage = carouselView?.getCurentPage() else {
                return
            }
            // update players score
            playersArray[curentPage].score += sender.tag
            // create histore object to save it in the history array
            let historyItem = HistoryData(player: playersArray[curentPage], playerIndex: curentPage, points: sender.tag)
            updateHistory(data: historyItem)
            
            carouselView?.changePoints(player: curentPage, points: playersArray[curentPage].score)
            carouselView?.nextPage()
            setImageForArrowsButtons()
        }
    }
    
    @objc func nextPage(_ sender: UIButton) {
        if playersArray.count != 0 {
            carouselView?.nextPage()
            setImageForArrowsButtons()
        }
    }
    
    func setImageForArrowsButtons() {        
        if (playersArray.count == 1) {
            nextButton.setBackgroundImage(UIImage(named: "icon_Previous-2"), for: .normal)
            previousButton.setBackgroundImage(UIImage(named: "icon_Previous"), for: .normal)
        } else {
            if (carouselView!.currentPage == playersArray.count - 2) ||  (carouselView!.currentPage == -1) {
                nextButton.setBackgroundImage(UIImage(named: "icon_Previous-2"), for: .normal)
            } else {
                nextButton.setBackgroundImage(UIImage(named: "icon_Next"), for: .normal)
            }
            if (carouselView!.currentPage == playersArray.count - 1) {
                previousButton.setBackgroundImage(UIImage(named: "icon_Previous"), for: .normal)
            } else {
                previousButton.setBackgroundImage(UIImage(named: "icon_Next-2"), for: .normal)
            }
        }
    }
    
    @objc func previousPage(_ sender: UIButton) {
        if playersArray.count != 0 {
            carouselView?.previousPage()
            setImageForArrowsButtons()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        carouselView?.configureView(with: carouselData)
        configureArrowsButtons()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newGameViewConroller.delegate = self
        carouselView = CarouselView(pages: 0, delegate: self)
        guard let carouselView = carouselView else { return }
        view.addSubview(carouselView)
        
        view.backgroundColor = UIColor(named: "BG")
        let pointButtonsArray = [minusTenPointButton, minusFivePointButton, minusOnePointButton, plusFivePointButton, plusTenPointButton]
        for itemButton in pointButtonsArray {
            pointsStackView.addArrangedSubview(itemButton)
        }
        
        let viewsArray = [newGameButton, resultsButton, titleLabel, diceButton, timerLabel,timerPlayButton, timerPauseButton, undoButton, plusOnePointButton, previousButton, nextButton, pointsStackView, pointsStackView]
        for itemView in viewsArray {
            view.addSubview(itemView)
        }
        
        // tap to close dice screen
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeDiceView(_:)))
        view.addGestureRecognizer(tap)
        
        NSLayoutConstraint.activate([
            newGameButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            newGameButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            resultsButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            resultsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 46.0),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            diceButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 54.0),
            diceButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            diceButton.widthAnchor.constraint(equalToConstant: 36.0),
            diceButton.heightAnchor.constraint(equalToConstant: 36.0),
            
            timerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            timerPlayButton.leadingAnchor.constraint(equalTo: timerLabel.trailingAnchor, constant: 20.0),
            timerPlayButton.heightAnchor.constraint(equalToConstant: 21.0),
            timerPlayButton.widthAnchor.constraint(equalToConstant: 16.0),
            timerPlayButton.centerYAnchor.constraint(equalTo: timerLabel.centerYAnchor),
            
            timerPauseButton.leadingAnchor.constraint(equalTo: timerLabel.trailingAnchor, constant: 20.0),
            timerPauseButton.heightAnchor.constraint(equalToConstant: 21.0),
            timerPauseButton.widthAnchor.constraint(equalToConstant: 16.0),
            timerPauseButton.centerYAnchor.constraint(equalTo: timerLabel.centerYAnchor),
            
            undoButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            undoButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40.0),
            
            plusOnePointButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -131.0),
            plusOnePointButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            plusOnePointButton.heightAnchor.constraint(equalToConstant: 90.0),
            plusOnePointButton.widthAnchor.constraint(equalToConstant: 90.0),
            
            previousButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 46),
            previousButton.centerYAnchor.constraint(equalTo: plusOnePointButton.centerYAnchor),
            previousButton.heightAnchor.constraint(equalToConstant: 30.0),
            previousButton.widthAnchor.constraint(equalToConstant: 34.0),
            
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50.0),
            nextButton.centerYAnchor.constraint(equalTo: plusOnePointButton.centerYAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 30.0),
            nextButton.widthAnchor.constraint(equalToConstant: 34.0),
            
            pointsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            pointsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            pointsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -54.0),
            pointsStackView.heightAnchor.constraint(equalToConstant: 55.0),
            
            minusTenPointButton.heightAnchor.constraint(equalToConstant: 55.0),
            minusTenPointButton.widthAnchor.constraint(equalToConstant: 55.0),
            minusFivePointButton.heightAnchor.constraint(equalToConstant: 55.0),
            minusFivePointButton.widthAnchor.constraint(equalToConstant: 55.0),
            minusOnePointButton.heightAnchor.constraint(equalToConstant: 55.0),
            minusOnePointButton.widthAnchor.constraint(equalToConstant: 55.0),
            plusFivePointButton.heightAnchor.constraint(equalToConstant: 55.0),
            plusFivePointButton.widthAnchor.constraint(equalToConstant: 55.0),
            plusTenPointButton.heightAnchor.constraint(equalToConstant: 55.0),
            plusTenPointButton.widthAnchor.constraint(equalToConstant: 55.0),
        ])
        
        // Set up constraints for the carousel view
        carouselView.translatesAutoresizingMaskIntoConstraints = false
        carouselView.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 32).isActive = true
        carouselView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        carouselView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        carouselView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        configureArrowsButtons()
        
    }
    
    func setPlayers(players: [Player]) {
        playersArray = players
        history.removeAll()
        for pl in players {
            pl.score = 0
        }
        carouselData.removeAll()
        carouselView?.setPages(pages: playersArray.count)
        
        for player in playersArray {
            carouselData.append(.init(name: player.name))
        }
        carouselView?.configureView(with: carouselData)
        configureArrowsButtons()
    }
    
    func configureArrowsButtons() {
        if playersArray.count <= 1 {
            previousButton.setBackgroundImage(UIImage(named: "icon_Previous"), for: .normal)
            nextButton.setBackgroundImage(UIImage(named: "icon_Previous-2"), for: .normal)
        } else {
            previousButton.setBackgroundImage(UIImage(named: "icon_Previous"), for: .normal)
            nextButton.setBackgroundImage(UIImage(named: "icon_Next"), for: .normal)
        }
    }
    @objc func newGameAction(_ sender: ActionButton) {
        present(newGameViewConroller, animated: true, completion: nil)
    }
    @objc func resultsAction(_ sender: ActionButton) {
        resultsViewConroller.data = playersArray
        resultsViewConroller.history = history
        present(resultsViewConroller, animated: true, completion: nil)
    }
    
    @objc func diceAction(_ sender: ActionButton) {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        view.addSubview(blurEffectView)
        // generate haptic feedback
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        // roll the dice
        diceView.image = UIImage(named: "dice_\(Int.random(in: 1..<7))")
        
        // using CATransaction to delay animation
        CATransaction.begin()
        view.addSubview(diceView)
        NSLayoutConstraint.activate([
            diceView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            diceView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            diceView.heightAnchor.constraint(equalToConstant: 120.0),
            diceView.widthAnchor.constraint(equalToConstant: 120.0),
        ])
        CATransaction.setCompletionBlock({
            Animation.shakeAnimation(on: self.diceView)
        })
        CATransaction.commit()
    }
    
    @objc func closeDiceView(_ sender: UIGestureRecognizer) {
        for subview in view.subviews {
            if subview is UIVisualEffectView {
                subview.removeFromSuperview() // to remove blur
            }
        }
        diceView.removeFromSuperview()
    }
    func updateHistory(data: HistoryData) {
        history.append(data)
    }
}


// MARK: - CarouselViewDelegate
extension ProcessViewController: CarouselViewDelegate {
    func currentPageDidChange(to page: Int) {
        UIView.animate(withDuration: 0.7) {
        }
    }
}
