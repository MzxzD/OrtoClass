//
//  HomeCalculateFooterView.swift
//  OrtoClass
//
//  Created by Mateo Doslic on 03/09/2018.
//  Copyright © 2018 Mateo Doslic. All rights reserved.
//

import UIKit

class CalculateFooterView: UIView {
    weak var validateAndOpenResultScreen: ValidateAndOpenResultScreenDelegate?
    var calculateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
//        let text = Theme.Styles.Text.Semibold.bigger.whiteColor
//        button.setTitleColor(text.textColor, for: .normal)
        button.setTitleColor(.black, for: .selected)
        button.setTitle("Calculate", for: .normal)
        button.reversesTitleShadowWhenHighlighted = true
        return button
    }()
    
    deinit {
        printDeinit()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        addSubview(calculateButton)
        setupConstraints()
        calculateButton.addTarget(self, action: #selector(calculateButtonTapped(_:)), for: .touchUpInside)
    }
    private func setupConstraints(){
        let constraints = [
            calculateButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            calculateButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            calculateButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            calculateButton.heightAnchor.constraint(equalToConstant: 44),
            ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func calculateButtonTapped(_: UIButton){
        validateAndOpenResultScreen?.calculateButtonTapped()
        
    }
}

protocol ValidateAndOpenResultScreenDelegate: class {
    func calculateButtonTapped()
}
