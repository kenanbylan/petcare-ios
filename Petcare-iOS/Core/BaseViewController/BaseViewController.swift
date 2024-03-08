//
//  BaseViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 11.02.2024.
//

import UIKit


class BaseViewController: UIViewController {
    private var keyboardHeight: CGFloat = 0
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        networkControl()
        setupKeyboardNotifications()
  //viewDidTapped()
    }
    
//    
//    func viewDidTapped() {
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//           view.addGestureRecognizer(tapGesture)
//    }
    
    
    deinit {
        removeKeyboardNotifications()
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        networkControl()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true) // Klavyeyi kapat
    }
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func networkControl() {
        if NetworkMonitor.shared.isConnected {
            print("You're connected")
            
            AlertView.shared.showAlert(title: "Title", message: "Message", buttonType: .multiButton, onPrimaryTapped: {
                print("Primary button tapped")
            }, onSecondaryTapped: {
                print("Secondary button tapped")
            })
        } else {
            
        }
    }
    
    fileprivate func setNavigationBar() {
        navigationItem.setCustomBackButtonTitle("Back", color: AppColors.primaryColor)
        navigationController?.navigationBar.tintColor = AppColors.primaryColor
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        keyboardHeight = keyboardFrame.height
        
        // Override edilebilir method
        keyboardWillShow(with: keyboardHeight)
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        keyboardHeight = 0
        keyboardWillHide()
    }
    
    @objc func keyboardWillShow(with height: CGFloat) {}
    
    @objc func keyboardWillHide() {
         // ScrollView'in content inset'ini sıfırla
    }
}
