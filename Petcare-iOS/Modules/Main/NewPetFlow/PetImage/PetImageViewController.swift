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
    
    //MARK: select pet image
    private lazy var petsNameLabel: CustomLabel = {
        let label = CustomLabel(text: "Add your pet image", fontSize: 17, fontType: .bold, textColor: AppColors.labelColor)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var petImages: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cat")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var patiButton: PatiButton = {
        let patiButton = PatiButton()
        patiButton.delegate = self
        return patiButton
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
        buildLayout()
        prepareTitleLabel()
        
    }
    
    private func prepareTitleLabel() {
        let titleLabel = TitleLabel.configurationTitleLabel(withText: "Wow !", fontSize: 17, textColor: AppColors.primaryColor)
        navigationItem.titleView = titleLabel
    }
}

extension PetImageViewController: PetImageViewProtocol, PatiButtonDelegate {
    
    func dismissScreen() { }
    
    func prepareUI() {
        view.backgroundColor = AppColors.bgColor
        
        petImages.backgroundColor = AppColors.bgColor
        petImages.layer.cornerRadius = 12
        petImages.layer.shadowColor = AppColors.customDarkGray.cgColor
        petImages.layer.shadowOpacity = 0.4
        petImages.layer.shadowOffset = CGSize(width: 0, height: 2)
        petImages.layer.shadowRadius = 4
        
        prepareTapGesture()
    }
    
    func patiButtonClicked(_ sender: PatiButton) {
        print(" Select Image clicked SaveButton")
        presenter?.navigateMainPage()
    }
    
    func getImage() { }
    
    func prepareTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        petImages.isUserInteractionEnabled = true
        petImages.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let vc = viewController as? UINavigationController {
            print("SELECTT TABBAR CLİCKED")
            vc.popToRootViewController(animated: false)
        }
    }
}

extension PetImageViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @objc func imageTapped() {
        UIView.animate(withDuration: 0.3, animations: {
            self.petImages.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { _ in
            UIView.animate(withDuration: 0.3) {
                self.petImages.transform = .identity
            }
        }
        
        showImagePicker()
    }
    
    private func showImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        
        let takePhotoAction = UIAlertAction(title: "Fotoğraf Çek", style: .default) { _ in
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
        }
        
        let chooseFromLibraryAction = UIAlertAction(title: "Kütüphaneden Seç", style: .default) { _ in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "İptal", style: .cancel, handler: nil)
        
        alertController.addAction(takePhotoAction)
        alertController.addAction(chooseFromLibraryAction)
        alertController.addAction(cancelAction)
        
        alertController.popoverPresentationController?.sourceView = petImages
        alertController.popoverPresentationController?.sourceRect = petImages.bounds
        
        present(alertController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            petImages.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

extension PetImageViewController: ViewCoding {
    
    func setupView() { }
    
    func setupHierarchy() {
        self.view.addSubview(petsNameLabel)
        self.view.addSubview(petImages)
        self.view.addSubview(patiButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            petsNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            petsNameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            petsNameLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            
            petImages.topAnchor.constraint(equalTo: petsNameLabel.bottomAnchor, constant: 20),
            petImages.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            petImages.leadingAnchor.constraint(equalTo: petsNameLabel.leadingAnchor, constant: 32),
            petImages.trailingAnchor.constraint(equalTo: petsNameLabel.trailingAnchor, constant: -32),
            
            petImages.heightAnchor.constraint(equalToConstant: 100),
            petImages.widthAnchor.constraint(equalTo: petImages.heightAnchor, multiplier: 3.0 / 4.0),
            
            patiButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            patiButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
        ])
    }
}
