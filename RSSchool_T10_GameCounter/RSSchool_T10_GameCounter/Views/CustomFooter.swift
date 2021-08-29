//
//  CustomFooter.swift
//  RSSchool_T10_GameCounter
//
//  Created by Liza Kryshkovskaya on 27.08.21.
//

import UIKit

class CustomFooter: UITableViewHeaderFooterView {
    
    var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Add"), for: .normal)
        button.setTitle("Add player", for: .normal)
        button.setTitleColor(UIColor(named: "CustomGreen"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15.0)
        button.titleLabel?.font = UIFont(name: "Nunito-Bold", size: 16)
        return button
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents() {
        contentView.addSubview(addButton)
        NSLayoutConstraint.activate([
            addButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            addButton.widthAnchor.constraint(equalToConstant: 120),
            addButton.heightAnchor.constraint(equalToConstant: 25),
            addButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
        ])
    }
}
