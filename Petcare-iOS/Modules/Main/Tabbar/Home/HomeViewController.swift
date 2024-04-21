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

enum CollectionViewType {
    case reminder
    case petAdd
    case appointment
}

final class HomeViewController: UIViewController {
    var presenter: HomePresenterProtocol?
    private var sliderView: SlideView?
    private var sliderData = [SlideView.SlideData]()
    
    var collectionViewType: CollectionViewType = .reminder // Örnek bir varsayılan değer
    
    
    //MARK: UI Properties
    private let scrollView: UIScrollView = {
        let sView = UIScrollView()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.contentInsetAdjustmentBehavior = .never
        sView.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
        sView.showsVerticalScrollIndicator = false
        return sView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var managePetsSectionLabel: CustomLabel = {
        let label = CustomLabel(text: "Manage Pets", fontSize: 14, fontType: .medium, textColor: AppColors.labelColor)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var upComingVeterinaryLabel: CustomLabel = {
        let upcoming = CustomLabel(text: "Upcoming Appointment", fontSize: 14, fontType: .medium, textColor: AppColors.labelColor)
        return upcoming
    }()
    
    private lazy var reminderVeterinaryLabel: CustomLabel = {
        let upcoming = CustomLabel(text: "Reminder's", fontSize: 14, fontType: .medium, textColor: AppColors.labelColor)
        return upcoming
    }()
    
    private lazy var nearbyView: NearbyVetView = {
        let view = NearbyVetView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addShadow(shadowColor: AppColors.bgColor.cgColor)
        return view
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution  = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var nearbyVeterinaryLabel: CustomLabel = {
        let upcoming = CustomLabel(text: "Nearby Veterinary", fontSize: 14, fontType: .medium, textColor: AppColors.labelColor)
        return upcoming
    }()
    
    private lazy var nearbySeeAllButton: SeeAllButton = {
        return SeeAllButtonBuilder()
            .withAction {
                self.presenter?.navigateToNearbyList(onlyShow: false)
            }
            .withOriginalImage(UIImage(named: "pati")!)
            .withTargetHeight(30)
            .build()
    }()
    
    private lazy var reminderButton: SeeAllButton = {
        return SeeAllButtonBuilder()
            .withAction {
                self.presenter?.navigateToReminder()
            }
            .withOriginalImage(UIImage(named: "pati")!)
            .withTargetHeight(30)
            .build()
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
    
    fileprivate lazy var reminderCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.screenWidth / 1.5 , height: UIScreen.screenWidth / 4)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.registerNib(with: "ReminderCell")
        collectionView.registerCodedCell(with: ReminderCell.self)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var stackView: CustomStackView = {
        let stackView = CustomStackView(axis: .vertical, alignment: .fill, distribution: .equalSpacing, spacing: 24)
        return stackView
    }()
    
    private lazy var secondaryTitleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution  = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
        prepareSlideView()
        scrollView.delegate = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        reminderCollectionView.delegate = self
        reminderCollectionView.dataSource = self
        
        setupConstraints()
        setHeader()
        // fetchApiFinder()
        collectionView.register(PetAvatarCellFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "PetAvatarCellFooter")
        
        reminderCollectionView.register(PetAvatarCellFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "PetAvatarCellFooter")
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sliderView?.configureView(with: sliderData)
    }
    
    private func prepareSlideView() {
        sliderView = SlideView(pages: 3, delegate: self)
        sliderData.append(.init(image: UIImage(named: "info-host"), text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit"))
        sliderData.append(.init(image: UIImage(named: "info-dog"),text: "elit"))
        sliderData.append(.init(image: UIImage(named: "info-cat"), text: "consectetur adipiscing elit"))
        sliderView?.configureView(with: sliderData)
    }
    
    private func fetchApiFinder() {
        let name = "dog".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://api.api-ninjas.com/v1/animals?name="+name!)!
        var request = URLRequest(url: url)
        request.setValue("n+FRtOsmJDY5YH4ELTn83A==pKyZcMz9B0i5Yfur", forHTTPHeaderField: "X-Api-Key")
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
            print("data: \(data)")
        }
        task.resume()
    }
    
    private func setHeader() {
        let titleLabel = UILabel()
        titleLabel.text = "Paw Buddy"
        
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
        presenter?.navigateToNearbyList(onlyShow: false)
    }
}

extension HomeViewController: SlideViewProtocol {
    func currentPageDidChange(to page: Int) {
        UIView.animate(withDuration: 0.7) {
            
        }
    }
}

extension HomeViewController: UICollectionViewDataSource , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView  {
            return 4
        }
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cell = collectionView.dequeCell(cellClass: PetAvatarCell.self, indexPath: indexPath)
            return cell
        }
        
        if collectionView == self.reminderCollectionView {
            let cell = collectionView.dequeCell(cellClass: ReminderCell.self, indexPath: indexPath)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("indexPath: \(indexPath)")
        
        presenter?.navigateToPetDetail(detail: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView == self.collectionView {
            
            if kind == UICollectionView.elementKindSectionFooter {
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "PetAvatarCellFooter", for: indexPath) as! PetAvatarCellFooter
                footer.setupView()
                footer.petAdd.addTarget(self, action: #selector(newPetButton), for: .touchUpInside)
                return footer
            }
        } else if collectionView == self.reminderCollectionView {
            if kind == UICollectionView.elementKindSectionFooter {
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "PetAvatarCellFooter", for: indexPath) as! PetAvatarCellFooter
                footer.setupView()
                footer.petAdd.addTarget(self, action: #selector(reminderAddButton), for: .touchUpInside)
                return footer
            }
        }
        /// Normally should never get here
        return UICollectionReusableView()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
}

extension HomeViewController: HomeViewProtocol {
    
    @objc func newPetButton() {
        presenter?.navigateToPetType()
    }
    
    @objc func reminderAddButton() {
        presenter?.navigateToReminder()
    }
    
    func prepareUI() {
        setupConstraints()
    }
    
    private func setupConstraints() {
        view.backgroundColor = AppColors.bgColor
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        let hConst = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        hConst.isActive = true
        hConst.priority = UILayoutPriority(50)
        
        guard let sliderView = sliderView else { return }
        contentView.addSubview(sliderView)
        
        contentView.addSubview(managePetsSectionLabel)
        contentView.addSubview(collectionView)
        contentView.addSubview(secondaryTitleStackView)
        contentView.addSubview(reminderCollectionView)
        contentView.addSubview(titleStackView)
        contentView.addSubview(nearbyView)
        contentView.addSubview(upComingVeterinaryLabel)
        contentView.addSubview(upComingVeterinaryView)
        
        titleStackView.addArrangedSubview(nearbyVeterinaryLabel)
        titleStackView.addArrangedSubview(UIView())
        titleStackView.addArrangedSubview(nearbySeeAllButton)
        
        secondaryTitleStackView.addArrangedSubview(reminderVeterinaryLabel)
        secondaryTitleStackView.addArrangedSubview(UIView())
        secondaryTitleStackView.addArrangedSubview(reminderButton)
        
        sliderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor,constant: -200),
            contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            
            sliderView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 24),
            sliderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            sliderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            sliderView.heightAnchor.constraint(equalToConstant: 25.hPercent),
            
            managePetsSectionLabel.topAnchor.constraint(equalTo: sliderView.bottomAnchor, constant: 12),
            managePetsSectionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            managePetsSectionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            collectionView.topAnchor.constraint(equalTo: managePetsSectionLabel.bottomAnchor,constant: 12),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: view.frame.width / 3),
            
            secondaryTitleStackView.topAnchor.constraint(equalTo: collectionView.bottomAnchor,constant: 12),
            secondaryTitleStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            secondaryTitleStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16),
            
            reminderCollectionView.topAnchor.constraint(equalTo: secondaryTitleStackView.bottomAnchor),
            reminderCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            reminderCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            reminderCollectionView.heightAnchor.constraint(equalToConstant: view.frame.width / 3),
            
            titleStackView.topAnchor.constraint(equalTo: reminderCollectionView.bottomAnchor, constant: 12),
            titleStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            nearbyView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 12),
            nearbyView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nearbyView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nearbyView.heightAnchor.constraint(equalToConstant: view.frame.width / 4),
            
            upComingVeterinaryLabel.topAnchor.constraint(equalTo: nearbyView.bottomAnchor, constant: 12),
            upComingVeterinaryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            upComingVeterinaryView.topAnchor.constraint(equalTo: upComingVeterinaryLabel.bottomAnchor, constant: 12),
            upComingVeterinaryView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            upComingVeterinaryView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            upComingVeterinaryView.heightAnchor.constraint(equalToConstant: view.frame.width / 4),
        ])
    }
}
