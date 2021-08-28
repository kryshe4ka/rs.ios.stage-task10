//
//  ResultsViewConroller.swift
//  RSSchool_T10_GameCounter
//
//  Created by Liza Kryshkovskaya on 26.08.21.
//

import UIKit

class ResultsViewConroller: UIViewController {

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
    }
    
    @objc func resumeAction(_ sender: ActionButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func newGameAction(_ sender: ActionButton) {
        present(newGameViewConroller, animated: true, completion: nil)
    }

}
