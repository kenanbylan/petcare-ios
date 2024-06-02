//
//  HomeViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 5.11.2023.

import UIKit
import CoreLocation

protocol HomeViewProtocol: AnyObject {
    func prepareUI()
    func getPetsSuccess(_ message: String)
    func getPetsFailure(_ message: String)
    func reloadData()
    func updateNearbyVetView()
}

final class HomeViewController: UIViewController {
    var presenter: HomePresenterProtocol?
    private let locationManager = LocationManager()
    private var sliderData = [SlideView.SlideData]()
    
    var sliderView: SlideView?
    
    //MARK: UI Properties
    let scrollView: UIScrollView = {
        let sView = UIScrollView()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.contentInsetAdjustmentBehavior = .never
        sView.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
        sView.showsVerticalScrollIndicator = false
        return sView
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var managePetsSectionLabel: CustomLabel = {
        let label = CustomLabel(text: "Home_pet_title".localized(), fontSize: 14, fontType: .medium, textColor: AppColors.labelColor)
        label.textAlignment = .left
        return label
    }()
    
    lazy var upComingVeterinaryLabel: CustomLabel = {
        let upcoming = CustomLabel(text: "Home_pet_upcoming_label".localized(), fontSize: 14, fontType: .medium, textColor: AppColors.labelColor)
        return upcoming
    }()
    
    lazy var reminderVeterinaryLabel: CustomLabel = {
        let upcoming = CustomLabel(text: "Home_pet_reminder_label".localized(), fontSize: 14, fontType: .medium, textColor: AppColors.labelColor)
        return upcoming
    }()
    
    lazy var veterinaryAppointmentLabel: CustomLabel = {
        let upcoming = CustomLabel(text: "Home_pet_upcoming_label".localized(), fontSize: 14, fontType: .medium, textColor: AppColors.labelColor)
        return upcoming
    }()
    
    lazy var nearbyView: NearbyVetView = {
        let view = NearbyVetView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addShadow(shadowColor: AppColors.bgColor.cgColor)
        return view
    }()
    
    lazy var reminderView: ReminderView = {
        let view = ReminderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addShadow(shadowColor: AppColors.bgColor.cgColor)
        return view
    }()
    
    lazy var titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution  = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var nearbyVeterinaryLabel: CustomLabel = {
        let upcoming = CustomLabel(text: "Home_nearby_veterinary_label".localized(), fontSize: 14, fontType: .medium, textColor: AppColors.labelColor)
        return upcoming
    }()
    
    lazy var nearbySeeAllButton: SeeAllButton = {
        return SeeAllButtonBuilder()
            .withAction {
                self.presenter?.navigateToNearbyList(onlyShow: false)
            }
            .withOriginalImage(UIImage(named: "pati")!)
            .withTargetHeight(30)
            .build()
    }()
    
    lazy var reminderButton: SeeAllButton = {
        return SeeAllButtonBuilder()
            .withAction {
                self.presenter?.navigateToReminder()
            }
            .withOriginalImage(UIImage(named: "pati")!)
            .withTargetHeight(30)
            .build()
    }()
    
    lazy var appointmentListButton: SeeAllButton = {
        return SeeAllButtonBuilder()
            .withAction {
                self.presenter?.navigateToReminder()
            }
            .withOriginalImage(UIImage(named: "pati")!)
            .withTargetHeight(30)
            .build()
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.screenWidth / 3.5 , height: UIScreen.screenWidth / 3.5)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.registerNib(with: "PetAvatarCell")
        collectionView.registerCodedCell(with: PetAvatarCell.self)
        collectionView.register(PetAvatarCellFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "PetAvatarCellFooter")
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    lazy var stackView: CustomStackView = {
        let stackView = CustomStackView(axis: .vertical, alignment: .fill, distribution: .equalSpacing, spacing: 24)
        return stackView
    }()
    
    lazy var secondaryTitleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution  = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var appointmentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution  = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var upComingVeterinaryView: UpcomingVeterinary = {
        let view = UpcomingVeterinary()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addShadow(shadowColor: AppColors.bgColor.cgColor)
        return  view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        prepareSlideView()
        prepareViews()
        locationManager.delegate = self
        locationManager.requestPermissionToAccessLocation()
        
        print("Login bilgileri :\(TokenManager.shared.email) , \(TokenManager.shared.userRole) ,\(TokenManager.shared.userId)"  )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
        updateReminderView()
        sliderView?.configureView(with: sliderData)
        presenter?.getUserPets()
    }
    
    private func prepareViews() {
        scrollView.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupConstraints()
        setHeader()
        updateReminderView()
        prepareShadowView()
    }
    
    private func prepareSlideView() {
        sliderView = SlideView(pages: 3, delegate: self)
        sliderData = presenter?.prepareSlideData() ?? []
        sliderView?.configureView(with: sliderData)
    }
    
    func prepareShadowView() {

        upComingVeterinaryView.addShadow(shadowColor: AppColors.labelColor.cgColor, shadowOffset: CGSize(width: 1, height: 2), shadowOpacity: 0.4, shadowRadius: 3)
        reminderView.addShadow(shadowColor: AppColors.labelColor.cgColor, shadowOffset: CGSize(width: 1, height: 2), shadowOpacity: 0.4, shadowRadius: 3)
        nearbyView.addShadow(shadowColor: AppColors.labelColor.cgColor, shadowOffset: CGSize(width: 1, height: 2), shadowOpacity: 0.4, shadowRadius: 3)

    }
    
    private func setHeader() {
        let titleLabel = UILabel()
        titleLabel.text = "Paw Buddies"
        
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
        presenter?.navigateToContractVetList()
    }
}

extension HomeViewController: LocationManagerDelegate {
    func didFailWithError(_ error: any Error) {
        print("errorerror \(error.localizedDescription)")
    }
    
    func didUpdateLocation(_ location: CLLocationCoordinate2D) {
        print("location: \(location)")
        presenter?.fetchNearbyVets(at: location)
    }
}

extension HomeViewController: SlideViewProtocol {
    func currentPageDidChange(to page: Int) { }
}

extension HomeViewController: UICollectionViewDataSource , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.pets.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellClass: PetAvatarCell.self, indexPath: indexPath)
        guard let pet = presenter?.pets[indexPath.item] else { return UICollectionViewCell() }
        cell.configure(with: pet)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let pet = presenter?.pets[indexPath.item] else { return }
        guard let petId = pet.id else { return }
        presenter?.getPetByPetId(petId: petId)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "PetAvatarCellFooter", for: indexPath) as! PetAvatarCellFooter
        footer.setupView()
        footer.petAdd.addTarget(self, action: #selector(newPetButton), for: .touchUpInside)
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
}

extension HomeViewController {
    func updateReminderView() {
        let defaults = UserDefaults.standard
        if let savedData = defaults.object(forKey: "data") as? Data {
            let jsonDecoder = JSONDecoder()
            do {
                let reminders = try jsonDecoder.decode([Reminder].self, from: savedData)
                if let latestReminder = reminders.last {
                    reminderView.configure(with: latestReminder)
                }
            } catch {
                print("Failed to load data.")
            }
        }
    }
}

extension HomeViewController: HomeViewProtocol {
    func updateNearbyVetView() {
        guard let latestData = presenter?.vet(at: 0) else { return  }
        nearbyView.configure(with: latestData)
    }
    
    func getPetsSuccess(_ message: String) {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func getPetsFailure(_ message: String) {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    @objc func newPetButton() {
        presenter?.navigateToPetType()
    }
    
    func prepareUI() {
        setupConstraints()
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension HomeViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        nearbyView.addShadow(shadowColor: AppColors.bgColor.cgColor)
        reminderView.addShadow(shadowColor: AppColors.bgColor.cgColor)
        upComingVeterinaryView.addShadow(shadowColor: AppColors.bgColor.cgColor)
    }
}
