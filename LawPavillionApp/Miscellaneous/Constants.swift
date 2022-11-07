//
//  Constants.swift
//  LawPavillionApp
//
//  Created by Apple on 5/15/22.
//

import Foundation
import UIKit

class Constants {
    
// MARK: - String Constants
    
    static let url = "https://api.github.com/search/users?q="
    
// MARK: - UI Constants
    
    static let navyBlue = UIColor(hex: "#2F466C")
    
    static func boldFont(size: Int) -> UIFont {
        
        return UIFont(name: "Poppins-Bold", size: CGFloat(size))!
    }
    
    static func regularFont(size: Int) -> UIFont {
        
        return UIFont(name: "Poppins-Regular", size: CGFloat(size))!
    }
    
    static func semiBoldFont(size: Int) -> UIFont {
        
        return UIFont(name: "Poppins-SemiBold", size: CGFloat(size))!
    }
    
    static func lightFont(size: Int) -> UIFont {
        
        return UIFont(name: "Poppins-Light", size: CGFloat(size))!
    }
    
// MARK: - String Constants
}
