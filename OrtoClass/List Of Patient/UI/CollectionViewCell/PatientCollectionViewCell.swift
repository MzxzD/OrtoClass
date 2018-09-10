//
//  PatientCollectionViewCell.swift
//  OrtoClass
//
//  Created by Mateo Doslic on 06/09/2018.
//  Copyright © 2018 Mateo Doslic. All rights reserved.
//

import UIKit

class PatientCollectionViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static let color = UIColor.black
    var patientName: UILabel = {
        let label = UILabel()
        label.text = "Generic Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label

    }()
    
    var patientPredictedSymptomLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Predicted Symptom: Normal"
        return label
    }()
    
    var normalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Normal"
        return label
        
    }()
    
    var normalProbabilityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0%"
        label.textColor = .blue

        return label
        
    }()
    
    var stackViewNormal: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    var herniaLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hernia"
        return label
        
    }()
    
    var herniaProbabilityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.text = "0%"
        return label
        
    }()
    
    var stackViewHernia: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    var spondylolisthesisLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Spondylolisthesis"
        return label
        
    }()
    
    var spondylolisthesisProbabilityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0%"
        label.textColor = UIColor(red:0.51, green:0.58, blue:0.34, alpha:1.0)

        return label
        
    }()
    
    var stackViewSpondylolisthesis: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    
    var containerNormalView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.addBorder(edge: UIRectEdge.right, color: color, thickness: 2)
        view.layer.addBorder(edge: UIRectEdge.left, color: color, thickness: 2)
        view.layer.addBorder(edge: UIRectEdge.top, color: color, thickness: 2)
        view.layer.addBorder(edge: UIRectEdge.bottom, color: color, thickness: 2)

        return view
    }()
    
    var containerHerniaView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.addBorder(edge: UIRectEdge.right, color: color, thickness: 2)
        view.layer.addBorder(edge: UIRectEdge.left, color: color, thickness: 2)
        view.layer.addBorder(edge: UIRectEdge.top, color: color, thickness: 2)
        view.layer.addBorder(edge: UIRectEdge.bottom, color: color, thickness: 2)
        return view
    }()
    
    var containerspondylolisthesisView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.addBorder(edge: UIRectEdge.right, color: color, thickness: 2)
        view.layer.addBorder(edge: UIRectEdge.left, color: color, thickness: 2)
        view.layer.addBorder(edge: UIRectEdge.top, color: color, thickness: 2)
        view.layer.addBorder(edge: UIRectEdge.bottom, color: color, thickness: 2)
        let layer = view.layer
        return view
    }()
    
    var stackViewProbabilityScore: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()
    


    
    private func setupUI(){
        contentView.backgroundColor = .white
  

        contentView.addSubviews(patientName, patientPredictedSymptomLabel,stackViewProbabilityScore) // stackViewNormal) //, containerHerniaView, containerspondylolisthesisView)
        stackViewNormal.addArrangedSubview(normalLabel)
        stackViewNormal.addArrangedSubview(normalProbabilityLabel)
        stackViewHernia.addArrangedSubview(herniaLabel)
        stackViewHernia.addArrangedSubview(herniaProbabilityLabel)
        stackViewSpondylolisthesis.addArrangedSubview(spondylolisthesisLabel)
        stackViewSpondylolisthesis.addArrangedSubview(spondylolisthesisProbabilityLabel)
        stackViewProbabilityScore.addArrangedSubview(stackViewNormal)
        stackViewProbabilityScore.addArrangedSubview(stackViewHernia)
        stackViewProbabilityScore.addArrangedSubview(stackViewSpondylolisthesis)

        setupConstraints()
    }
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
//        stackViewNormal.layer.addBorder(edge: UIRectEdge.right, color: PatientCollectionViewCell.color, thickness: 2)
//        stackViewNormal.layer.addBorder(edge: UIRectEdge.left, color: PatientCollectionViewCell.color, thickness: 2)
//        stackViewNormal.layer.addBorder(edge: UIRectEdge.top, color: PatientCollectionViewCell.color, thickness: 2)
//        stackViewNormal.layer.addBorder(edge: UIRectEdge.bottom, color: PatientCollectionViewCell.color, thickness: 2)
//
//        stackViewHernia.layer.addBorder(edge: UIRectEdge.right, color: PatientCollectionViewCell.color, thickness: 2)
//        stackViewHernia.layer.addBorder(edge: UIRectEdge.left, color: PatientCollectionViewCell.color, thickness: 2)
//        stackViewHernia.layer.addBorder(edge: UIRectEdge.top, color: PatientCollectionViewCell.color, thickness: 2)
//        stackViewHernia.layer.addBorder(edge: UIRectEdge.bottom, color: PatientCollectionViewCell.color, thickness: 2)
//
//
//        stackViewSpondylolisthesis.layer.addBorder(edge: UIRectEdge.right, color: PatientCollectionViewCell.color, thickness: 2)
//        stackViewSpondylolisthesis.layer.addBorder(edge: UIRectEdge.left, color: PatientCollectionViewCell.color, thickness: 2)
//        stackViewSpondylolisthesis.layer.addBorder(edge: UIRectEdge.top, color: PatientCollectionViewCell.color, thickness: 2)
//        stackViewSpondylolisthesis.layer.addBorder(edge: UIRectEdge.bottom, color: PatientCollectionViewCell.color, thickness: 2)
        
        
    }
    
    

    
    private func setupConstraints(){
        
        let constraints = [

            patientName.topAnchor.constraint(equalTo: self.topAnchor,constant: 5),
            patientName.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10),
            patientName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            patientPredictedSymptomLabel.topAnchor.constraint(equalTo: patientName.bottomAnchor, constant: 5),
            patientPredictedSymptomLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10),
            patientPredictedSymptomLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
//            normalLabel.topAnchor.constraint(equalTo: containerNormalView.topAnchor),
//            herniaLabel.topAnchor.constraint(equalTo: containerHerniaView.topAnchor),
//            spondylolisthesisLabel.topAnchor.constraint(equalTo: containerspondylolisthesisView.topAnchor),
            
            stackViewProbabilityScore.topAnchor.constraint(equalTo: patientPredictedSymptomLabel.bottomAnchor, constant: 5),
            stackViewProbabilityScore.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            stackViewProbabilityScore.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            //            containerNormalView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
//
//            containerHerniaView.topAnchor.constraint(equalTo: containerNormalView.topAnchor, constant: 5),
//            containerHerniaView.leftAnchor.constraint(equalTo: containerNormalView.rightAnchor, constant: 10),
//
//            containerspondylolisthesisView.topAnchor.constraint(equalTo: containerHerniaView.topAnchor, constant: 5),
//            containerspondylolisthesisView.leftAnchor.constraint(equalTo: containerHerniaView.rightAnchor, constant: 10),
            

            ]

        NSLayoutConstraint.activate(constraints)
    }
    
}
