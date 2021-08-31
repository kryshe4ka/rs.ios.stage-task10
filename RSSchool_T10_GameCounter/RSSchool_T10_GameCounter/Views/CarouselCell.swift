//
//  CarouselCell.swift
//  RSSchool_T10_GameCounter
//
//  Created by Liza Kryshkovskaya on 28.08.21.
//

import UIKit

class CarouselCell: UICollectionViewCell {
    
    private lazy var bgView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "CustomGray")
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Nunito-ExtraBold", size: 28)
        label.textAlignment = .center
        label.textColor = UIColor(named: "CustomOrange")
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Nunito-ExtraBold", size: 100)
        label.textAlignment = .center
        label.textColor = .white
        label.text = "0"
        label.numberOfLines = 1
        return label
    }()
    
    static let cellId = "CarouselCell"
    
    // Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
}

private extension CarouselCell {
    func setupUI() {
        backgroundColor = .clear
        
        addSubview(bgView)
        bgView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        bgView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        bgView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        bgView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.37).isActive = true

        bgView.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 23).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: bgView.centerXAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 39).isActive = true
        
        bgView.addSubview(scoreLabel)
        scoreLabel.centerYAnchor.constraint(equalTo: bgView.centerYAnchor).isActive = true
        scoreLabel.centerXAnchor.constraint(equalTo: bgView.centerXAnchor).isActive = true
        scoreLabel.heightAnchor.constraint(equalToConstant: 139).isActive = true
                
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
    }
}

// MARK: - Public
extension CarouselCell {
    public func configure(name: String) {
        nameLabel.text = name
        scoreLabel.text = "0"
    }
    
    public func setPoints(points: Int) {
        scoreLabel.text = "\(points)"
    }
}
