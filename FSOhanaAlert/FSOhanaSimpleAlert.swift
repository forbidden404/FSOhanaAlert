//
//  FSOhanaSimpleAlert.swift
//  FSOhanaAlert
//
//  Created by Francisco Soares on 26/10/17.
//  Copyright © 2017 Francisco Soares. All rights reserved.
//

import UIKit

public enum FSOhanaAlertType {
    case takeActivity
    case leaveActivity
}

public class FSOhanaSimpleAlert {
    static public let shared: FSOhanaSimpleAlert = FSOhanaSimpleAlert()
    
    private init() { }
    
    public func showAlert(with type: FSOhanaAlertType, completion: @escaping ((Any?, Error?) -> Void)) -> UIAlertController {
        switch type {
        case .takeActivity:
            return showTakeAlert(completion: completion)
        case .leaveActivity:
            return showLeaveAlert(completion: completion)
        }
    }
    
    public func showTakeAlert(completion: @escaping ((Any?, Error?) -> Void)) -> UIAlertController {
        let alertController = UIAlertController(title: "Take Activity", message: "Are you sure you want to take this activity?", preferredStyle: .alert)
        
        let takeAction = UIAlertAction(title: "Take", style: .default) { action in
            completion(action, nil)
        }
        alertController.addAction(takeAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            completion(nil, FSError.RightButton)
        }
        alertController.addAction(cancelAction)
        
        return alertController
    }
    
    public func showLeaveAlert(completion: @escaping ((Any?, Error?) -> Void)) -> UIAlertController {
        let alertController = UIAlertController(title: "Leave Activity", message: "Are you sure you want to leave this activity?", preferredStyle: .alert)
        
        let takeAction = UIAlertAction(title: "Leave", style: .default) { action in
            completion(action, nil)
        }
        alertController.addAction(takeAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            completion(nil, FSError.LeftButton)
        }
        alertController.addAction(cancelAction)
        
        return alertController
    }
}

public enum FSError: Error {
    case NoResultFound
    case LeftButton
    case RightButton
}

