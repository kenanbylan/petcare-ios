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
    
    private lazy var titleNameLabel: CustomLabel = {
        let titleName = CustomLabel(text: "Hello, Kenan Baylan", fontSize: 24, fontType: .bold, textColor: AppColors.primaryColor)
        return titleName
    }()
    
    private lazy var upComingVeterinary: CustomLabel = {
        let upcoming = CustomLabel(text: "Upcoming Veterinarty", fontSize: 14, fontType: .medium, textColor: .black)
        return upcoming
    }()
 
    private lazy var notificationButton: UIButton = {
        let button = UIButton()
//        if let originalImage = {
//            let aspectRatio = originalImage.size.width / originalImage.size.height
//            let targetHeight: CGFloat = 30.0
//            let targetWidth = targetHeight * aspectRatio
//            let resizedImage = originalImage.resized(to: CGSize(width: targetWidth, height: targetHeight))
//            button.tintColor = .blue
//        }
//
        
        if let currentImage = button.currentImage {
            let resizedImage = currentImage.resized(to: CGSize(width: 40, height: 40))
            button.setImage(resizedImage, for: .normal)
        }

        //button.setImage(UIImage(systemName: "bell.circle.fill"), for: .normal)
        //button.currentImage?.resized(to: CGSize(width: 40, height: 40))
        button.setTitleColor(.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector((notificationButtonClicked)), for: .touchUpInside)
        button.setTitleColor(.tintColor, for: .normal)
        return button
    }()

    fileprivate lazy var sectionStackView: UICustomStackView = {
        let stack = UICustomStackView()
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
    
    fileprivate lazy var topStackView: UICustomStackView = {
        let stack = UICustomStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        return stack
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupConstraints()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @objc func notificationButtonClicked() {
        print("notificationButtonClicked    ")
    }
}

extension HomeViewController: UICollectionViewDataSource , UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PetAvatarCell", for: indexPath)
        
        return cell
    }
    
}

extension HomeViewController: HomeViewProtocol {
    
    func prepareUI() {
        view.backgroundColor = AppColors.bgColor
        
        view.addSubview(topStackView)
        view.addSubview(collectionView)
        view.addSubview(sectionStackView)
        view.addSubview(upComingVeterinary)

        topStackView.addArrangedSubview(titleNameLabel)
        topStackView.addArrangedSubview(UIView())
        topStackView.addArrangedSubview(notificationButton)
        
        sectionStackView.addArrangedSubview(managePetsSectionLabel)
        sectionStackView.addArrangedSubview(UIView())
        sectionStackView.addArrangedSubview(seeAllPetsButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: view.topAnchor,constant: 60),
            topStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            topStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
            
            sectionStackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 40),
            sectionStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            sectionStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            collectionView.topAnchor.constraint(equalTo: sectionStackView.bottomAnchor,constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
            collectionView.heightAnchor.constraint(equalToConstant: view.frame.width / 3),
            
            upComingVeterinary.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16),
            upComingVeterinary.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        ])
    }
    
    func getPets() {
        
    }
}
