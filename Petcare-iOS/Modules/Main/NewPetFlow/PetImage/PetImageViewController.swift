//
//  PetImageViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 3.01.2024.
//

import UIKit

protocol PetImageViewProtocol: AnyObject {
    func prepareUI()
    func getImage()
    func dismissScreen()
}

final class PetImageViewController: UIViewController {
    
    var presenter: PetImagePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
        buildLayout()
        prepareTitleLabel()
    }
}

extension PetImageViewController: PetImageViewProtocol {
    func dismissScreen() {
        
    }
    
    func prepareUI() {
        view.backgroundColor = .systemGreen
    }

    func getImage() { }
    
    private func prepareTitleLabel() {
        let titleLabel = UILabel()
        titleLabel.configurationTitleLabel(withText: "Wow! Clips Image", fontSize: 17, textColor: AppColors.primaryColor)
        navigationItem.titleView = titleLabel
    }
}

extension PetImageViewController: ViewCoding {
    func setupView() { }
    
    func setupHierarchy() { }
    
    func setupConstraints() { }
    
}
