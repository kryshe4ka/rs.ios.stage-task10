//
//  PointButton.swift
//  RSSchool_T10_GameCounter
//
//  Created by Liza Kryshkovskaya on 25.08.21.
//

import UIKit

class PointButton: UIButton {

    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        setTitleColor(UIColor.white, for: .normal)
        backgroundColor = UIColor(named: "CustomGreen")
        layer.masksToBounds = true
        titleLabel?.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        titleLabel?.layer.shadowColor = UIColor(named: "ShadowColor")?.cgColor
        titleLabel?.layer.masksToBounds = false
        titleLabel?.layer.shadowOpacity = 1.0
        titleLabel?.layer.shadowRadius = 0
    }

}
