//
//  NewGameViewController.swift
//  RSSchool_T10_GameCounter
//
//  Created by Liza Kryshkovskaya on 26.08.21.
//

import UIKit

class NewGameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddPlayerViewControllerDelegate {
    
    private lazy var cancelButton: ActionButton = {
        let button = ActionButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cancel", for: .normal)
        button.addTarget(self, action: #selector(cancelAction(_ :)), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: TitleLabel = {
        let label = TitleLabel()
        label.text = "Game Counter"
        return label
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start game", for: .normal)
        button.backgroundColor = UIColor(named: "CustomGreen")
        button.layer.cornerRadius = 32.5
        button.layer.shadowColor = UIColor(named: "ShadowColor")?.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 5.0)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 0
        button.layer.masksToBounds = false
        button.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 24)
        button.titleLabel?.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        button.titleLabel?.layer.shadowRadius = 0
        button.titleLabel?.layer.masksToBounds = false
        button.titleLabel?.layer.shadowOpacity = 1.0
        button.titleLabel?.layer.shadowColor = UIColor(named: "ShadowColor")?.cgColor
        button.addTarget(self, action: #selector(startGame(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = UIColor(named: "CustomGray")
        table.layer.cornerRadius = 15
        return table
    }()
    
    var delegate: NewGameViewControllerDelegate?
    var playersArray: [Player] = []
    var heightConstraint = NSLayoutConstraint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BG")
        view.addSubview(cancelButton)
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(startButton)
        
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "NotFirstStart") {
            cancelButton.isHidden = false
        } else {
            cancelButton.isHidden = true
        }
        // This view controller itself will provide the delegate methods and row data for the table view
        tableView.delegate = self
        tableView.dataSource = self
        // Register the table view cell class and its reuse id
        tableView.register(PlayerTableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        // Register the custom header view.
        tableView.register(CustomHeader.self, forHeaderFooterViewReuseIdentifier: "SectionHeader")
        // Register the custom footer view.
        tableView.register(CustomFooter.self, forHeaderFooterViewReuseIdentifier: "SectionFooter")
        
        heightConstraint = NSLayoutConstraint(item: tableView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 100.0)
        
        NSLayoutConstraint.activate([
            cancelButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 46.0),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25.0),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            heightConstraint,

            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -65.0),
            startButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            startButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            startButton.heightAnchor.constraint(equalToConstant: 65.0),
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playersArray.count
    }
    
    // Create a custom header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SectionHeader") as! CustomHeader
       view.title.text = "Players"
       return view
    }
    
    // Create a custom footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SectionFooter") as! CustomFooter
        view.addButton.addTarget(self, action: #selector(addPlayer(_:)), for: .touchUpInside)
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! PlayerTableViewCell
        cell.setUpView()
        cell.titleLabel.text = playersArray[indexPath.row].name
        cell.deleteButton.addTarget(self, action: #selector(deletePlayer(_:)), for: .touchUpInside)
        cell.deleteButton.tag = indexPath.row
        return cell
    }
    
    @objc func addPlayer(_ sender: UIButton) {
        let addPlayerViewController = AddPlayerViewController()
        addPlayerViewController.delegate = self
        addChild(addPlayerViewController)
        UIView.transition(with: self.view, duration: 0.25, options: [.beginFromCurrentState], animations: {
          self.view.addSubview(addPlayerViewController.view)
        }, completion: nil)
        addPlayerViewController.didMove(toParent: self)
    }
    func setName(_ name: String) {
        playersArray.append(Player.init(name: name))
        let indexPath = IndexPath(row: playersArray.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        heightConstraint.constant += 54
        tableView.layoutIfNeeded()
    }
    
    @objc func deletePlayer(_ sender: UIButton) {
        handleDelete(indexPath: IndexPath(row: sender.tag, section: 0))
    }

    private func handleDelete(indexPath: IndexPath) {
        playersArray.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        heightConstraint.constant -= 54
        tableView.layoutIfNeeded()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Remove") { [weak self] (action, view, completionHandler) in
            self?.handleDelete(indexPath: indexPath)
            completionHandler(true)
        }
        action.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        54
    }
    
    @objc func cancelAction(_ sender: ActionButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func startGame(_ sender: UIButton) {
        if playersArray.count != 0 {
            if let delegate = self.presentingViewController as? NewGameViewControllerDelegate {
                delegate.setPlayers(players: playersArray)
                delegate.clearTimer()
                delegate.startTimer()
            } else {
                if let delegate = self.presentingViewController?.presentingViewController as? NewGameViewControllerDelegate {
                    delegate.setPlayers(players: playersArray)
                    delegate.clearTimer()
                    delegate.startTimer()
                }
            }
            self.dismiss(animated: true, completion: nil)
        } else {
            // unactive button
        }
        
        self.dismiss(animated: true, completion: nil)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    
}
