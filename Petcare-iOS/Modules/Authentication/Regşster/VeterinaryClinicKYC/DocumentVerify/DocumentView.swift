//
//  DocumentView.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 9.04.2024.
//

import Foundation
import UIKit
import PDFKit

final class DocumentView: UIView {
    // Görüntü veya PDF göstermek için alt görünüm
    private lazy var documentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear // Gerekirse arka plan rengini ayarlayın
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Görüntü görüntüleyici
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .lightBlue
        return imageView
    }()
    
    // PDF görüntüleyici
    private lazy var pdfView: PDFView = {
        let pdfView = PDFView()
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        pdfView.backgroundColor = .systemGreen
        return pdfView
    }()
    
    // DocumentView'ı başlatma
    init() {
        super.init(frame: .zero)
        setupDocumentView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // DocumentView içindeki alt görünümleri ayarlama
    private func setupDocumentView() {
        addSubview(documentView)
        backgroundColor = .systemRed
        layer.cornerRadius = 20
        layer.borderWidth = 2
        
        // DocumentView'a alt görünümün eklenmesi ve boyutlandırılması
        NSLayoutConstraint.activate([
            documentView.topAnchor.constraint(equalTo: topAnchor),
            documentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            documentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            documentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // Görüntü eklemek için işlev
    func setImage(_ image: UIImage?) {
        guard let image = image else { return }
        imageView.image = image
        documentView.addSubview(imageView)
        imageView.frame = documentView.bounds
    }
    
    // PDF eklemek için işlev
    func setPDF(_ pdfURL: URL) {
        guard let pdfDocument = PDFDocument(url: pdfURL) else { return }
        pdfView.document = pdfDocument
        documentView.addSubview(pdfView)
        pdfView.frame = documentView.bounds
    }
    
//    private func setupGestureRecognizer() {
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapDocumentView))
//        documentView.addGestureRecognizer(tapGesture)
//        documentView.isUserInteractionEnabled = true
//    }
    
//    @objc private func didTapDocumentView() {
//        // Doküman seçme işlemini başlat
//        // Bu noktada bir görüntü veya PDF seçme işlemi başlatılabilir.
//        // Örneğin UIImagePickerController kullanılabilir.
//        // Seçilen belge DocumentView'a setImage veya setPDF işlevi ile ayarlanabilir.
//        print("DocumentView'a tıklandı!")
//        
//        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.content"], in: .import)
//        documentPicker.delegate = self
//        documentPicker.allowsMultipleSelection = false // Tek bir belge seçilecek
//
//        present(documentPicker, animated: true, completion: nil)
//    }

}

