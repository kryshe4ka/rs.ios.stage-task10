//
//  CustomHeader.swift
//  RSSchool_T10_GameCounter
//
//  Created by Liza Kryshkovskaya on 27.08.21.
//

import UIKit

class CustomHeader: UITableViewHeaderFooterView {

    let title = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents() {
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = UIColor(named: "CustomLightGray")
        title.font = UIFont(name: "Nunito-Bold", size: 16)
        title.alpha = 0.6
        contentView.addSubview(title)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
        ])
    }
    
}
