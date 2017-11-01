//
//  FSOhanaHelper.swift
//  FSOhanaAlert
//
//  Created by Francisco Soares on 01/11/17.
//  Copyright © 2017 Francisco Soares. All rights reserved.
//

import Foundation

public enum FSOhanaAlertType {
    case takeActivity
    case leaveActivity
}

public enum FSOhanaButtonType {
    case cancel
    case destructive
    case standard
    
    func color() -> UIColor {
        switch self {
        case .cancel:
            return #colorLiteral(red: 0.4539884329, green: 0.8202964067, blue: 0.8575808406, alpha: 1)
        case .destructive:
            return #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        case .standard:
            return #colorLiteral(red: 0.4539884329, green: 0.8202964067, blue: 0.8575808406, alpha: 1)
        }
    }
    
    func font() -> UIFont {
        switch self {
        case .cancel:
            return UIFont.systemFont(ofSize: UIFont.systemFontSize)
        default:
            return UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
        }
    }
}

public enum FSError: Error {
    case NoResultFound
    case LeftButton
    case RightButton
}
