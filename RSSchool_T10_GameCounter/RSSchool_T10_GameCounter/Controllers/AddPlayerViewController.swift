//
//  AddPlayerViewController.swift
//  RSSchool_T10_GameCounter
//
//  Created by Liza Kryshkovskaya on 27.08.21.
//

import UIKit

protocol AddPlayerViewControllerDelegate {
    func  setName(_ name: String)
}

class AddPlayerViewController: UIViewController {
    private lazy var backButton: ActionButton = {
        let button = ActionButton()
        button.setTitle("Back", for: .normal)
        button.addTarget(self, action: #selector(backButtonAction(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var addButton: ActionButton = {
        let button = ActionButton()
        button.setTitle("Add", for: .normal)
        button.addTarget(self, action: #selector(addButtonAction(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: TitleLabel = {
        let label = TitleLabel()
        label.text = "Add Player"
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = UIColor(named: "CustomGray")
        field.font = UIFont(name: "Nunito-ExtraBold", size: 20)
        field.textColor = UIColor(named: "PlayerNameColor")
        field.attributedPlaceholder = NSAttributedString(string: "Player Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "PlayerNameColor")!])
        field.becomeFirstResponder()
        return field
    }()
    
    var name = ""
    
    var delegate: AddPlayerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BG")
        view.addSubview(backButton)
        view.addSubview(addButton)
        view.addSubview(titleLabel)
                
        let subview = UIView()
        subview.backgroundColor = UIColor(named: "CustomGray")
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.addSubview(nameTextField)
        view.addSubview(subview)
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 46.0),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            subview.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25.0),
            subview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            subview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            subview.heightAnchor.constraint(equalToConstant: 65.0),
            
            nameTextField.centerYAnchor.constraint(equalTo: subview.centerYAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            nameTextField.heightAnchor.constraint(equalToConstant: 42.0),
        ])
    }
    
    @objc func backButtonAction(_ sender: ActionButton) {
        UIView.animate(withDuration: 0.25) { [self] in
            view.frame = CGRect(x: view.bounds.size.width, y: 0, width: view.bounds.size.width, height: 0)
        } completion: { _ in
            self.willMove(toParent: nil)
            self.view.removeFromSuperview()
        }
    }
    
    @objc func addButtonAction(_ sender: ActionButton) {
        
        if nameTextField.text! == "" {
            // do nothing
        } else {
            delegate?.setName(nameTextField.text!)            
            UIView.animate(withDuration: 0.25) { [self] in
                view.frame = CGRect(x: view.bounds.size.width, y: 0, width: view.bounds.size.width, height: 0)
            } completion: { _ in
                self.willMove(toParent: nil)
                self.view.removeFromSuperview()
                self.removeFromParent()
            }
        }
    }
}
