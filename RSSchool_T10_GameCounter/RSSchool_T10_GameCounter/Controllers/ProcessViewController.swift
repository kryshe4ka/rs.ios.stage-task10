//
//  ProcessViewController.swift
//  RSSchool_T10_GameCounter
//
//  Created by Liza Kryshkovskaya on 25.08.21.
//

import UIKit

class ProcessViewController: UIViewController {
    
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
        label.textColor = .white
        return label
    }()
    
    private lazy var timerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Play"), for: .normal)
//        button.setImage(UIImage(named: "Pause"), for: .normal)
        return button
    }()
    
    private lazy var undoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Undo"), for: .normal)
        return button
    }()
    
    private lazy var miniBarLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "K J B"
        label.font = UIFont(name: "Nunito-ExtraBold", size: 20)
//        label.textColor = UIColor(named: "MiniBarActiveColor")
        label.textColor = UIColor(named: "CustomGray")
        return label
    }()
    
    private lazy var plusOnePointButton: PointButton = {
        let button = PointButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 40)
        button.layer.cornerRadius = 45
        button.setTitle("+1", for: .normal)
        return button
    }()
    
    private lazy var previousButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            //button.setImage(UIImage(systemName: "arrow.left.to.line.alt"), for: .normal)
            button.setBackgroundImage(UIImage(systemName: "arrow.left.to.line"), for: .normal)
        } else {
            // Fallback on earlier versions
        }
        button.tintColor = UIColor(named: "CustomOrange")
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            button.setBackgroundImage(UIImage(systemName: "arrow.right.to.line"), for: .normal)
        } else {
            // Fallback on earlier versions
        }
        button.tintColor = UIColor(named: "CustomOrange")
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
        return button
    }()
    private lazy var plusTenPointButton: PointButton = {
        let button = PointButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 25)
        button.layer.cornerRadius = 27.5
        button.setTitle("+10", for: .normal)
        return button
    }()
    
    private lazy var minusFivePointButton: PointButton = {
        let button = PointButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 25)
        button.layer.cornerRadius = 27.5
        button.setTitle("-5", for: .normal)
        return button
    }()
    private lazy var minusOnePointButton: PointButton = {
        let button = PointButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 25)
        button.layer.cornerRadius = 27.5
        button.setTitle("-1", for: .normal)
        return button
    }()
    private lazy var minusTenPointButton: PointButton = {
        let button = PointButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 25)
        button.layer.cornerRadius = 27.5
        button.setTitle("-10", for: .normal)
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BG")
        let pointButtonsArray = [minusTenPointButton, minusFivePointButton, minusOnePointButton, plusFivePointButton, plusTenPointButton]
        for itemButton in pointButtonsArray {
            pointsStackView.addArrangedSubview(itemButton)
        }
        
        let viewsArray = [newGameButton, resultsButton, titleLabel, diceButton, timerLabel, timerButton, undoButton, miniBarLabel, plusOnePointButton, previousButton, nextButton, pointsStackView, pointsStackView]
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
            
            timerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 116),
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            timerButton.leadingAnchor.constraint(equalTo: timerLabel.trailingAnchor, constant: 20.0),
            timerButton.heightAnchor.constraint(equalToConstant: 21.0),
            timerButton.widthAnchor.constraint(equalToConstant: 16.0),
            timerButton.centerYAnchor.constraint(equalTo: timerLabel.centerYAnchor),
            
            undoButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32.0),
            undoButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40.0),
            
            miniBarLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            miniBarLabel.centerYAnchor.constraint(equalTo: undoButton.centerYAnchor),
            
            plusOnePointButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -151.0),
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
            pointsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -74.0),
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

    }
    
    @objc func newGameAction(_ sender: ActionButton) {
        present(newGameViewConroller, animated: true, completion: nil)
    }
    @objc func resultsAction(_ sender: ActionButton) {
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


}
