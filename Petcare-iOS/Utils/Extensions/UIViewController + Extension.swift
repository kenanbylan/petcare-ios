//
//  UIViewController + Extension.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 2.03.2024.


import UIKit

protocol CustomAlert {
    func newShowAlert(_ message: String?, action: ((UIAlertAction) -> Void)?)
}

extension CustomAlert where Self: UIViewController {
    func newShowAlert(_ message: String?, action: ((UIAlertAction) -> Void)? = nil) {
        let alertViewController = UIAlertController(title: "Error" , message: message, preferredStyle: .alert)
        alertViewController.addAction(.init(title: "Ok" , style: .default, handler: action))
        self.present(alertViewController, animated: true)
    }
}

extension UIViewController {
    func setupKeyboardDismissRecognizer() {
        let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tapRecognizer)
        tapRecognizer.cancelsTouchesInView = false
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    func showAlert(for alert: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Uyarı", message: alert, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showAlert(title: String, message: String, type: UIAlertController.Style, action: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: type)
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                action?()
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showAlertAction(title: String, message: String, type: UIAlertController.Style, action: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: type)
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                action?()
            }
            alertController.addAction(okAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

