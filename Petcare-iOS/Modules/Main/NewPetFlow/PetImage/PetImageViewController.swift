//
//  PetImageViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 3.01.2024.
//

import UIKit

protocol PetImageViewProtocol: AnyObject {
    func prepareUI()
    func savePetsSuccess(message: String)
    func savePetsError(message: String)
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
    
    private lazy var appButton: AppButton = {
        let appbutton = AppButton.build()
            .setImage(UIImage(named: "pati")?.resized(to: CGSize(width: 25, height: 25)))
            .setTitle("Save")
            .setTitleColor(AppColors.labelColor)
        appbutton.addTarget(self, action: #selector(patiButtonClicked) , for: .touchUpInside)
        appbutton.isEnabled = false
        return appbutton
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
        prepareUI()
        prepareTitleLabel()
    }
    
    private func prepareTitleLabel() {
        let titleLabel = TitleLabel.configurationTitleLabel(withText: "Wow !", fontSize: 17, textColor: AppColors.primaryColor)
        navigationItem.titleView = titleLabel
    }
}

extension PetImageViewController: PetImageViewProtocol {
    func savePetsSuccess(message: String) {
        showAlert(title: "Success", message: message , type: .alert) {
            //action
            self.presenter?.navigateMainPage()
        }
    }
    
    func savePetsError(message: String) {
        showAlert(title: "Error", message: message, type: .alert)
    }
    
    func prepareUI() {
        view.backgroundColor = AppColors.bgColor
        petImages.backgroundColor = AppColors.bgColor
        petImages.layer.cornerRadius = 12
        petImages.layer.shadowColor = AppColors.customLightGray.cgColor
        petImages.layer.shadowOpacity = 0.4
        petImages.layer.shadowOffset = CGSize(width: 4, height: 4)
        petImages.layer.shadowRadius = 4
        
        prepareTapGesture()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        petImages.layer.shadowColor = AppColors.customLightGray.cgColor
    }
    
    @objc func patiButtonClicked() {
        print(" Select Image clicked SaveButton")
        presenter?.fetchRequest()
    }
    
    func prepareTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        petImages.isUserInteractionEnabled = true
        petImages.addGestureRecognizer(tapGestureRecognizer)
    }
}

extension PetImageViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @objc func imageTapped() {
        UIView.animate(withDuration: 0.3, animations: {
            self.petImages.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { _ in
            UIView.animate(withDuration: 0.3) {
                self.petImages.transform = .identity
                self.showImagePicker()
            }
        }
    }
    
    private func showImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
 
        let chooseFromLibraryAction = UIAlertAction(title: "Kütüphaneden Seç", style: .default) { _ in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "İptal", style: .cancel, handler: nil)
        alertController.addAction(chooseFromLibraryAction)
        alertController.addAction(cancelAction)
        
        alertController.popoverPresentationController?.sourceView = petImages
        alertController.popoverPresentationController?.sourceRect = petImages.bounds
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            petImages.image = pickedImage
            
            if let imageData = pickedImage.jpegData(compressionQuality: 0.9) {
                let imageBase64String = imageData.base64EncodedString()
                presenter?.saveImage(data: imageBase64String)
                appButton.isEnabled = true
            }
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
        view.addSubview(petsNameLabel)
        view.addSubview(petImages)
        view.addSubview(appButton)
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
            
            petImages.heightAnchor.constraint(equalToConstant: UIScreen.screenWidth / 3),
            petImages.widthAnchor.constraint(equalTo: petImages.heightAnchor, multiplier: 3.0 / 4.0),
            
            appButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            appButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 5.wPercent),
            appButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -5.wPercent),
        ])
    }
}
