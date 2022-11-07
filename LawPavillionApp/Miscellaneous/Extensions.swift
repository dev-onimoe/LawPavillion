//
//  Extensions.swift
//  LawPavillionApp
//
//  Created by Apple on 5/12/22.
//

import Foundation
import UIKit

extension UIView {
    
    func constraint (equalToTop: NSLayoutYAxisAnchor? = nil,
                         equalToBottom: NSLayoutYAxisAnchor? = nil,
                         equalToLeft: NSLayoutXAxisAnchor? = nil,
                         equalToRight: NSLayoutXAxisAnchor? = nil,
                         paddingTop: CGFloat = 0,
                         paddingBottom: CGFloat = 0,
                         paddingLeft: CGFloat = 0,
                         paddingRight: CGFloat = 0,
                         width: CGFloat? = nil,
                         height: CGFloat? = nil
        ) {
            
            translatesAutoresizingMaskIntoConstraints = false
            
            if let equalToTop = equalToTop {
                
                topAnchor.constraint(equalTo: equalToTop, constant: paddingTop).isActive = true
            }
            
            if let equalTobottom = equalToBottom {
                
                bottomAnchor.constraint(equalTo: equalTobottom, constant: -paddingBottom).isActive = true
            }
            
            if let equalToLeft = equalToLeft {
                
                leadingAnchor.constraint(equalTo: equalToLeft, constant: paddingLeft).isActive = true
            }
            
            if let equalToRight = equalToRight {
                
                trailingAnchor.constraint(equalTo: equalToRight, constant: -paddingRight).isActive = true
            }
            
            if let width = width {
                
                widthAnchor.constraint(equalToConstant: width).isActive = true
            }
            
            if let height = height {
                
                heightAnchor.constraint(equalToConstant: height).isActive = true
            }
        }
        
    func centre (centerX: NSLayoutXAxisAnchor? = nil, centreY: NSLayoutYAxisAnchor? = nil) {
            
            translatesAutoresizingMaskIntoConstraints = false

            if let centerx = centerX {
                
                centerXAnchor.constraint(equalTo: centerx).isActive = true
            }
            
            if let centery = centreY {
                
                centerYAnchor.constraint(equalTo: centery).isActive = true
            }
        }

    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
             let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
             let mask = CAShapeLayer()
             mask.path = path.cgPath
             layer.mask = mask
         }

    func showtoast(message2: String) {
            
            DispatchQueue.main.async {
                let toastView = UIView()
                toastView.alpha = 0
                self.addSubview(toastView)
                self.bringSubviewToFront(toastView)
                toastView.backgroundColor = .black
                toastView.constraint(equalToBottom: self.bottomAnchor, equalToLeft: self.leadingAnchor, equalToRight: self.trailingAnchor, paddingBottom: 60, paddingLeft: 30, paddingRight: 30)
                toastView.layer.cornerRadius = 10
                
                let message = UILabel()
                toastView.addSubview(message)
                message.text = message2
                message.textColor = .white
                message.font = UIFont(name: "Roboto-Regular", size: 13)
                message.textAlignment = .center
                message.numberOfLines = 0
                message.constraint(equalToTop: toastView.topAnchor, equalToBottom: toastView.bottomAnchor, equalToLeft: toastView.leadingAnchor, equalToRight: toastView.trailingAnchor, paddingTop: 15, paddingBottom: 15, paddingLeft: 5, paddingRight: 5, width: nil)
                
                
                UIView.animate(withDuration: 0.5, animations: {toastView.alpha = 1})
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                    UIView.animate(withDuration: 0.2, animations: {toastView.alpha = 0})
                })
            }
            
            
            
        }

    func shadowBorder (){
            
            self.layer.cornerRadius = 10
            self.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0).cgColor
            self.layer.shadowOffset = CGSize(width: 0, height: 1.75)
            self.layer.shadowRadius = 1.7
            self.layer.shadowOpacity = 0.2
            
        }
    
    func centreHorizontally(view : UIView, y : Double, height : Double, width: Double) {
        
        view.frame = CGRect(x: (frame.width/2.0) - (width/2.0), y: y, width: width, height: height)
        
        addSubview(view)
        
    }
}

extension UIColor {
    
    convenience init(hex: String) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        var hex:   String = hex

        if hex.hasPrefix("#") {
            let index   = hex.index(hex.startIndex, offsetBy: 1)
            hex         = hex.substring(from: index)
        }

        let scanner = Scanner(string: hex)
        var hexValue: CUnsignedLongLong = 0
        if scanner.scanHexInt64(&hexValue) {
            switch (hex.count) {
            case 3:
                red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                blue  = CGFloat(hexValue & 0x00F)              / 15.0
            case 4:
                red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                alpha = CGFloat(hexValue & 0x000F)             / 15.0
            case 6:
                red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
            case 8:
                red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
            default:
                print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8", terminator: "")
            }
        } else {
            print("Scan hex error")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}
