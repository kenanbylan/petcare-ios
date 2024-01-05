//
//  HomeViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 5.11.2023.
//

import UIKit
import SwiftUI

protocol HomeViewProtocol: AnyObject {
    func prepareUI()
    func getPets()
}

final class HomeViewController: UIViewController {
    var presenter: HomePresenterProtocol?
    
    private lazy var managePetsSectionLabel: CustomLabel = {
        let label = CustomLabel(text: "Manage Pets", fontSize: 14, fontType: .medium, textColor: AppColors.labelColor)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var seeAllPetsButton: SeeAllButton = {
        let button = SeeAllButton()
        button.setTitle("See All", for: .normal)
        button.setTitleColor(AppColors.primaryColor, for: .normal)
        button.titleLabel?.font = AppFonts.medium.font(size: 12)
        return button
    }()
    
    private lazy var upComingVeterinary: CustomLabel = {
        let upcoming = CustomLabel(text: "Upcoming Veterinary", fontSize: 14, fontType: .medium, textColor: .black)
        return upcoming
    }()
 

    fileprivate lazy var sectionStackView: CustomStackView = {
        let stack = CustomStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.screenWidth / 4 , height: UIScreen.screenWidth / 4)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PetAvatarCell.self, forCellWithReuseIdentifier: "PetAvatarCell")
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    
    private lazy var upComingVeterinaryView: UpcomingVeterinary = {
        let view = UpcomingVeterinary()
        view.translatesAutoresizingMaskIntoConstraints = false
        return  view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = UILabel()
        titleLabel.text = "Pet Care"
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = AppFonts.bold.font(size: 24)
        titleLabel.textColor = AppColors.primaryColor
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"),
                                        style: .plain,
                                        target: self,
                                        action: #selector(addButtonTapped))
        addButton.tintColor = AppColors.primaryColor
        navigationItem.rightBarButtonItem = addButton
        
        presenter?.viewDidLoad()
        setupConstraints()
        setNavigationBar()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    @objc func addButtonTapped() {
        presenter?.navigateToPetType()
    }
    
    private func setNavigationBar() {
        navigationItem.setCustomBackButtonTitle("Back", color: AppColors.primaryColor)
        navigationController?.navigationBar.tintColor = AppColors.primaryColor
    }
}

extension HomeViewController: UICollectionViewDataSource , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PetAvatarCell", for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)  // İstediğiniz boşluğu burada belirleyebilirsiniz
    }
    
}

extension HomeViewController: HomeViewProtocol {
    
    func prepareUI() {
        view.backgroundColor = AppColors.bgColor
        
        view.addSubview(sectionStackView)
        view.addSubview(collectionView)
        view.addSubview(upComingVeterinary)
        view.addSubview(upComingVeterinaryView)
        
        sectionStackView.addArrangedSubview(managePetsSectionLabel)
        sectionStackView.addArrangedSubview(UIView())
        sectionStackView.addArrangedSubview(seeAllPetsButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([

            sectionStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 30),
            sectionStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            sectionStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            collectionView.topAnchor.constraint(equalTo: sectionStackView.bottomAnchor,constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 0),
            collectionView.heightAnchor.constraint(equalToConstant: view.frame.width / 3),
            
            upComingVeterinary.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16),
            upComingVeterinary.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            upComingVeterinaryView.topAnchor.constraint(equalTo: upComingVeterinary.bottomAnchor, constant: 16),
            upComingVeterinaryView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            upComingVeterinaryView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            upComingVeterinaryView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    func getPets() {
        
    }
}
