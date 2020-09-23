//
//  ErrorActionSheetExtension.swift
//  Reddit
//
//  Created by LAURA JELENICH on 9/23/20.
//

import UIKit

extension UIViewController {
    func presentErrorToUser(locializedError: LocalizedError) {
        let alertController = UIAlertController(title: "Error", message: locializedError.errorDescription, preferredStyle: .actionSheet)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel)
        alertController.addAction(dismissAction)
        present(alertController, animated: true)
    }
}
