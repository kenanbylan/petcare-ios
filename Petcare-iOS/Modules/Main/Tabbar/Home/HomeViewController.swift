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
}

final class HomeViewController: UIViewController {
    var presenter: HomePresenterProtocol?
    
    private lazy var managePetsSectionLabel: CustomLabel = {
        let label = CustomLabel(text: "Manage Pets", fontSize: 14, fontType: .medium, textColor: AppColors.labelColor)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var upComingVeterinaryLabel: CustomLabel = {
        let upcoming = CustomLabel(text: "Upcoming Appointment", fontSize: 14, fontType: .medium, textColor: AppColors.labelColor)
        return upcoming
    }()
    
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.screenWidth / 3.5 , height: UIScreen.screenWidth / 3.5)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.registerNib(with: "PetAvatarCell")
        collectionView.registerCodedCell(with: PetAvatarCell.self)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    
    private lazy var upComingVeterinaryView: UpcomingVeterinary = {
        let view = UpcomingVeterinary()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addShadow(shadowColor: AppColors.bgColor.cgColor)
        return  view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        setupConstraints()
        setHeader()
    }
    
    private func setHeader() {
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
    }
    
    @objc func addButtonTapped() {
        presenter?.navigateToPetType()
    }
}

extension HomeViewController: UICollectionViewDataSource , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellClass: PetAvatarCell.self, indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("indexPath: \(indexPath)")
        presenter?.navigateToPetDetail(detail: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}

extension HomeViewController: HomeViewProtocol {
    
    func prepareUI() {
        view.backgroundColor = AppColors.bgColor
        view.addSubview(managePetsSectionLabel)
        view.addSubview(collectionView)
        view.addSubview(upComingVeterinaryLabel)
        view.addSubview(upComingVeterinaryView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            managePetsSectionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 24),
            managePetsSectionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            managePetsSectionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            collectionView.topAnchor.constraint(equalTo: managePetsSectionLabel.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: view.frame.width / 3),
            
            upComingVeterinaryLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16),
            upComingVeterinaryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            upComingVeterinaryView.topAnchor.constraint(equalTo: upComingVeterinaryLabel.bottomAnchor, constant: 16),
            upComingVeterinaryView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            upComingVeterinaryView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            upComingVeterinaryView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
}

