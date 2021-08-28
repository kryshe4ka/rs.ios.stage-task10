//
//  TitleLabel.swift
//  RSSchool_T10_GameCounter
//
//  Created by Liza Kryshkovskaya on 26.08.21.
//

import UIKit

class TitleLabel: UILabel {

    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        font = UIFont(name: "Nunito-ExtraBold", size: 36)
        textColor = .white
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    

}
