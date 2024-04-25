//
//  DocumentVerifyViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 31.03.2024.

import UIKit
import TipKit
import PDFKit

protocol DocumentVerifyViewProtocol: AnyObject {
    func documentSave()
}

final class DocumentVerifyViewController: UIViewController {
    var presenter: DocumentVerifyPresenterProtocol?
    
    private let textLabel: CustomLabel = {
        let label = CustomLabel(text: "DocumentVerifyView_HEADER".localized(), fontSize: 17, fontType: .semibold, textColor: AppColors.primaryColor)
        label.textAlignment = .justified
        return label
    }()
    
    // Sağ üst köşede yer alacak buton.
    private lazy var infoPopupButton: UIButton = {
        let button = UIButton(type: .infoDark)
        button.tintColor = AppColors.primaryColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "doc.circle.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = AppColors.primaryColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var appButton: AppButton = {
        let appbutton = AppButton.build()
            .setImage(UIImage(systemName: "doc.circle")?.resized(to: CGSize(width: 25, height: 25)))
            .setTitle("Document save")
            .setTitleColor(AppColors.primaryColor)
        appbutton.addTarget(self, action: #selector(documentButtonClicked) , for: .touchUpInside)
        appbutton.isEnabled = false
        return appbutton
    }()
    
    private let documentView: UIView = {
        let view = UIView()
        view.addShadow(shadowColor: AppColors.customGray.cgColor)
        view.layer.borderWidth = 1.5
        view.layer.borderColor = AppColors.customGray.cgColor
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        buildLayout()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(documentViewTapped))
        documentView.addGestureRecognizer(tapGesture)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        view.layer.borderColor = AppColors.customGray.cgColor
        view.addShadow(shadowColor: AppColors.customGray.cgColor)
    }
    
    @objc func documentViewTapped() {
        showDocumentSelectionAlert()
    }
    
    @objc func documentButtonClicked() {
        showAlert(title: "Harika", message: "Veteriner klinik başvurunuz kabul edilmiştir. Başvurunuz incelenmeye başlanmıştır. Sizi bilgilendireceğiz. Hesabınızı aktifleştirmek için mail adresinize gelen kodu giriniz.", type: .alert) {
            self.presenter?.navigateToResult()
        }
    }
    @objc func infoButtonTapped(_ sender: UIButton) {
        showAlert(title: "Information", message: "DocumentVerifyView_INFO_ALERT".localized(), type: .alert)
    }
}

extension DocumentVerifyViewController {
    func showDocumentSelectionAlert() {
        let alert = UIAlertController(title: "DocumentVerifyView_BottomSheet_Title".localized(), message: nil, preferredStyle: .actionSheet)
        
        let imageAction = UIAlertAction(title: "DocumentVerifyView_BottomSheet_IMAGE".localized(), style: .default) { _ in
            self.showImagePicker()
        }
        let pdfAction = UIAlertAction(title: "DocumentVerifyView_BottomSheet_pdf".localized(), style: .default) { _ in
            self.showDocumentPicker()
        }
        
        let cancelAction = UIAlertAction(title: "DocumentVerifyView_BottomSheet_Cancel".localized(), style: .cancel, handler: nil)
        alert.addAction(imageAction)
        alert.addAction(pdfAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    func showDocumentPicker() {
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["com.adobe.pdf"], in: .import)
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .fullScreen
        present(documentPicker, animated: true, completion: nil)
    }
}

extension DocumentVerifyViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate, UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else { return }
        handleSelectedPDF(selectedFileURL)
        do {
            let pdfData = try Data(contentsOf: selectedFileURL)
            //MARK: - burada kaydedilecek
        } catch {
            print("PDF dosyasını veriye dönüştürme hatası: \(error)")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage, let imageURL = info[.imageURL] as? URL {
            appButton.isEnabled = true
            let imageData = pickedImage.jpegData(compressionQuality: 0.8)
            //MARK: - Image Data backendde gönderilecektir.
            handleSelectedImage(imageURL)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension DocumentVerifyViewController {
    func handleSelectedImage(_ imageURL: URL) {
        for subview in documentView.subviews {
            subview.removeFromSuperview()
        }
        
        if let image = UIImage(contentsOfFile: imageURL.path) {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            documentView.addSubview(imageView)
            
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: documentView.topAnchor),
                imageView.leadingAnchor.constraint(equalTo: documentView.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: documentView.trailingAnchor),
                imageView.bottomAnchor.constraint(equalTo: documentView.bottomAnchor)
            ])
            
            dismiss(animated: true, completion: nil) // Image picker'ı kapat
        } else {
            showAlert(for: "DocumentVerifyView_BottomSheet_handle_image_error".localized())
        }
    }
    
    func handleSelectedPDF(_ pdfURL: URL) {
        imageView.image = nil
        
        for subview in documentView.subviews {
            subview.removeFromSuperview()
        }
        
        let pdfView = PDFView(frame: documentView.bounds)
        pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        pdfView.displayMode = .singlePageContinuous
        pdfView.autoScales = true
        
        if let document = PDFDocument(url: pdfURL) {
            pdfView.document = document
            appButton.isEnabled = true
            documentView.addSubview(pdfView)
            
        } else {
            showAlert(for: "DocumentVerifyView_BottomSheet_handle_pdf_error".localized())
        }
    }
}

extension DocumentVerifyViewController: ViewCoding {
    func setupView() {
        view.backgroundColor = AppColors.bgColor
        title = "DocumentVerifyView_Title".localized()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: infoPopupButton)
    }
    
    func setupHierarchy() {
        view.addSubview(textLabel)
        view.addSubview(documentView)
        view.addSubview(appButton)
        documentView.addSubview(imageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            documentView.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 20),
            documentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            documentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            documentView.heightAnchor.constraint(equalToConstant: 240),
            
            infoPopupButton.widthAnchor.constraint(equalToConstant: 24),
            infoPopupButton.heightAnchor.constraint(equalToConstant: 24),
            
            appButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            appButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 5.wPercent),
            appButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -5.wPercent),
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: documentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: documentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: documentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: documentView.bottomAnchor),
        ])
    }
}
