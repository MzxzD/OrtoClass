//
//  CalculatorAnalasysResultHeaderView.swift
//  ePetrokemija
//
//  Created by Luka Lovretić on 14/08/2018.
//  Copyright © 2018 Factory. All rights reserved.
//

import UIKit
class HeaderView: UIView {
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.applyStyle(Theme.Styles.Text.Semibold.big.whiteColor)
//        label.backgroundColor = .grayColor
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(titleLabel)
        backgroundColor = UIColor(red:0.12, green:0.77, blue:1.00, alpha:1.0)
        setupConstraints()
    }
    
    private func setupConstraints(){
        let constraints = [
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 27),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
