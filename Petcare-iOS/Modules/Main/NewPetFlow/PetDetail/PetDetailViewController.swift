//
//  PetDetailViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 13.02.2024.
//

import UIKit


protocol PetDetailViewProtocol: AnyObject {
    func setupUI()
}

class PetDetailViewController: UIViewController {
    var presenter: PetDetailPresenterProtocol?
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "tes tes tes"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemRed
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 2
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        view.backgroundColor = AppColors.bgColor
        textView.text = "dapskdpğaskdpğakspdkğasdksağdkapsğdkpğaskpğdpkğdakpağs"
        textView.isEditable = true
        prepareConstraint()
    }
    
    private func prepareConstraint() {
        view.addSubview(textView)
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 40),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textView.heightAnchor.constraint(equalToConstant: 100),
            
            label.topAnchor.constraint(equalTo: textView.bottomAnchor,constant: 20),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
        ])
    }
}

extension PetDetailViewController: PetDetailViewProtocol {
    func setupUI() { }
    
}
