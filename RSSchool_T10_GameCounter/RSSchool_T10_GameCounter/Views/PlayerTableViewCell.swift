//
//  PlayerTableViewCell.swift
//  RSSchool_T10_GameCounter
//
//  Created by Liza Kryshkovskaya on 27.08.21.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Nunito-ExtraBold", size: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "icon_Delete"), for: .normal)
        return button
    }()
    
    private lazy var sortButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "icon_Sort"), for: .normal)
        return button
    }()
    
    func setUpView() {
        contentView.isUserInteractionEnabled = false // to avoid UITableViewCellContentView covering up controls inside cell
        backgroundColor = UIColor(named: "CustomGray")
        addSubview(deleteButton)
        addSubview(titleLabel)
        addSubview(sortButton)
        
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            deleteButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            titleLabel.centerYAnchor.constraint(equalTo: deleteButton.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: deleteButton.trailingAnchor, constant: 15),

            sortButton.centerYAnchor.constraint(equalTo: deleteButton.centerYAnchor),
            sortButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        // Configure the view for the selected state - do nothing
    }

}
