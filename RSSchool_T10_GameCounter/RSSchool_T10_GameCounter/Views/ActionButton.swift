//
//  ActionButton.swift
//  RSSchool_T10_GameCounter
//
//  Created by Liza Kryshkovskaya on 25.08.21.
//

import UIKit

class ActionButton: UIButton {

    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        setTitleColor(UIColor(named: "CustomGreen"), for: .normal)
        titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 17)
    }

}
