//
//  CALayer+Extension.swift
//  OrtoClass
//
//  Created by Mateo Doslic on 06/09/2018.
//  Copyright © 2018 Mateo Doslic. All rights reserved.
//

import Foundation
import UIKit

extension CALayer {
    
    func getBorder()
    {
        let layer = CALayer()
        layer.addBorder(edge: UIRectEdge.right, color: PatientCollectionViewCell.color, thickness: 2)
        layer.addBorder(edge: UIRectEdge.left, color: PatientCollectionViewCell.color, thickness: 2)
        layer.addBorder(edge: UIRectEdge.top, color: PatientCollectionViewCell.color, thickness: 2)
        layer.addBorder(edge: UIRectEdge.bottom, color: PatientCollectionViewCell.color, thickness: 2)
    }
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x: 0, y: self.frame.height - thickness, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x: self.frame.width - thickness, y: 0, width: thickness, height: self.frame.height)
            break
        default:
            //For Center Line
            border.frame = CGRect(x: self.frame.width/2 - thickness, y: 0, width: thickness, height: self.frame.height)
            break
        }
        
        border.backgroundColor = color.cgColor;
        self.addSublayer(border)
    }
}
