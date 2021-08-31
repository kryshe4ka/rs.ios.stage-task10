//
//  ResultsViewConroller.swift
//  RSSchool_T10_GameCounter
//
//  Created by Liza Kryshkovskaya on 26.08.21.
//

import UIKit

class ResultsViewConroller: UIViewController {

    var data: [Player] = []
    var history: [HistoryData] = []
    
    var delegate: NewGameViewControllerDelegate?
    
    private lazy var turnsView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(named: "CustomGray")
        v.layer.cornerRadius = 15
        return v
    }()
    
    private lazy var turnsLabel: UILabel = {
        let label = UILabel()
        label.text = "Turns"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "CustomLightGray")
        label.font = UIFont(name: "Nunito-Bold", size: 16)
        label.alpha = 0.6
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(named: "BG")
        return v
    }()
    
    private lazy var resultsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var turnsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.backgroundColor = UIColor(named: "CustomGray")
        stackView.layer.cornerRadius = 15
        return stackView
    }()
    
    private lazy var titleLabel: TitleLabel = {
        let label = TitleLabel()
        label.text = "Results"
        return label
    }()
    
    private lazy var newGameButton: ActionButton = {
        let button = ActionButton()
        button.setTitle("New Game", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(newGameAction(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var resumeButton: ActionButton = {
        let button = ActionButton()
        button.setTitle("Resume", for: .normal)
        button.addTarget(self, action: #selector(resumeAction(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var newGameViewConroller: NewGameViewController = {
        let controller = NewGameViewController()
        return controller
    }()
    
    
    private var heightConstraint = NSLayoutConstraint()
    private var heightConstraint2 = NSLayoutConstraint()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureStackView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BG")
        view.addSubview(titleLabel)
        view.addSubview(newGameButton)
        view.addSubview(resumeButton)
        
        NSLayoutConstraint.activate([
            newGameButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            newGameButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            resumeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            resumeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 46.0),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
        ])
        
        view.addSubview(scrollView)
        // constrain the scroll view
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        scrollView.addSubview(resultsStackView)
        turnsView.addSubview(turnsLabel)
        scrollView.addSubview(turnsView)
        scrollView.addSubview(turnsStackView)

        heightConstraint = NSLayoutConstraint(item: resultsStackView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 0)
        heightConstraint2 = NSLayoutConstraint(item: turnsStackView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 0)

        // constrain the results stack view
        NSLayoutConstraint.activate([
            resultsStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            resultsStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 18),
            resultsStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
        ])
        // constrain the turns view
        NSLayoutConstraint.activate([
            turnsView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            turnsView.topAnchor.constraint(equalTo: resultsStackView.bottomAnchor, constant: 25),
            turnsView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            turnsView.heightAnchor.constraint(equalToConstant: 100),
            turnsView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        //constrain the turnsLabel
        turnsLabel.topAnchor.constraint(equalTo: turnsView.topAnchor, constant: 16).isActive = true
        turnsLabel.leadingAnchor.constraint(equalTo: turnsView.leadingAnchor, constant: 16).isActive = true
        turnsLabel.trailingAnchor.constraint(equalTo: turnsView.trailingAnchor, constant: -11).isActive = true
        turnsLabel.heightAnchor.constraint(equalToConstant: 24.0).isActive = true
        // constrain the turns stack view
        NSLayoutConstraint.activate([
            turnsStackView.leadingAnchor.constraint(equalTo: turnsView.leadingAnchor),
            turnsStackView.topAnchor.constraint(equalTo: turnsLabel.bottomAnchor, constant: 17),
            turnsStackView.trailingAnchor.constraint(equalTo: turnsView.trailingAnchor),
            heightConstraint2,
        ])
    }
    
    func configureStackView() {
        for subview in resultsStackView.subviews { subview.removeFromSuperview() }
        for subview in turnsStackView.subviews { subview.removeFromSuperview() }
        let sortedData = data.sorted(by: { $0.score > $1.score })
        
        for (index, player) in sortedData.enumerated() {
            let rankView = UIView(frame: .zero)
            rankView.translatesAutoresizingMaskIntoConstraints = false
            resultsStackView.addArrangedSubview(rankView)

            let rankLabel = UILabel()
            rankLabel.translatesAutoresizingMaskIntoConstraints = false
            rankLabel.text = "#\(index+1)"
            rankLabel.textColor = UIColor.white
            rankLabel.font = UIFont(name: "Nunito-ExtraBold", size: 28)
            rankView.addSubview(rankLabel)
            
            let nameLabel = UILabel()
            nameLabel.translatesAutoresizingMaskIntoConstraints = false
            nameLabel.text = "\(player.name)"
            nameLabel.textColor = UIColor(named: "CustomOrange")
            nameLabel.font = UIFont(name: "Nunito-ExtraBold", size: 28)
            rankView.addSubview(nameLabel)
            
            let scoreLabel = UILabel()
            scoreLabel.translatesAutoresizingMaskIntoConstraints = false
            scoreLabel.text = "\(player.score)"
            scoreLabel.textColor = UIColor.white
            scoreLabel.font = UIFont(name: "Nunito-ExtraBold", size: 28)
            rankView.addSubview(scoreLabel)
            
            NSLayoutConstraint.activate([
                rankView.heightAnchor.constraint(equalToConstant: 41.0),
                nameLabel.leadingAnchor.constraint(equalTo: rankLabel.trailingAnchor, constant: 10),
                scoreLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
            ])
        }
        
        for item in history.reversed() {
            let turnsItemView = UIView(frame: .zero)
            turnsItemView.translatesAutoresizingMaskIntoConstraints = false
            let bottomBorder = CALayer()
            bottomBorder.frame = CGRect(x: 16, y: 0, width: turnsStackView.frame.size.width, height: 1.0)
            bottomBorder.backgroundColor = UIColor(named: "DevidorColor")!.cgColor
            turnsItemView.layer.addSublayer(bottomBorder)
            
            let turnsLabel = UILabel()
            turnsLabel.translatesAutoresizingMaskIntoConstraints = false
            turnsLabel.text = "\(item.player!.name)"
            turnsLabel.textColor = UIColor.white
            turnsLabel.font = UIFont(name: "Nunito-ExtraBold", size: 20)
            turnsItemView.addSubview(turnsLabel)
            
            let turnsPointLabel = UILabel()
            turnsPointLabel.translatesAutoresizingMaskIntoConstraints = false
            if item.points > 0 {
                turnsPointLabel.text = "+\(item.points)"
            } else {
                turnsPointLabel.text = "\(item.points)"
            }
            turnsPointLabel.textAlignment = .right
            turnsPointLabel.textColor = UIColor.white
            turnsPointLabel.font = UIFont(name: "Nunito-ExtraBold", size: 20)
            turnsItemView.addSubview(turnsPointLabel)
            
            turnsStackView.addArrangedSubview(turnsItemView)
            NSLayoutConstraint.activate([
                turnsItemView.heightAnchor.constraint(equalToConstant: 55.0),
                turnsLabel.leadingAnchor.constraint(equalTo: turnsStackView.leadingAnchor, constant: 15),
                turnsPointLabel.trailingAnchor.constraint(equalTo: turnsStackView.trailingAnchor, constant: -15),
                turnsLabel.centerYAnchor.constraint(equalTo: turnsItemView.centerYAnchor),
                turnsPointLabel.centerYAnchor.constraint(equalTo: turnsItemView.centerYAnchor),
            ])
        }
        
        heightConstraint.constant = (50.0 * (CGFloat(data.count)))
        heightConstraint2.constant = 55.0 * (CGFloat(history.count))

        // constrain the turns stack view
        NSLayoutConstraint.activate([
            heightConstraint,
            heightConstraint2
        ])
        
        // set contentSize for scrollView
        let contentHeight = 50.0 * (CGFloat(data.count) + CGFloat(history.count))
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: contentHeight)

    }
    
    @objc func resumeAction(_ sender: ActionButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func newGameAction(_ sender: ActionButton) {
        let vc = NewGameViewController()
        vc.delegate = self.delegate
        present(vc, animated: true, completion: nil)
    }

}
