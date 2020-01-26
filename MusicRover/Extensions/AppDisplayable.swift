//
//  AppDisplayable.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 25/01/20.
//  Copyright © 2020 MyOrganization. All rights reserved.
//

import UIKit

protocol AppDisplayable {
    func display(title: String,
                 error: String,
                 actions: [UIAlertAction])
}

extension AppDisplayable where Self: UIViewController {
    
    func display(title: String,
                 error: String,
                 actions: [UIAlertAction]) {
        let alertController = UIAlertController(
            title: title,
            message: error,
            preferredStyle: .alert
        )
        for action in actions {
            alertController.addAction(action)
        }
        
        guard let rootController = UIApplication.shared.keyWindow?.rootViewController else { return }
        rootController.present(alertController, animated: true, completion: nil)
    }
}
