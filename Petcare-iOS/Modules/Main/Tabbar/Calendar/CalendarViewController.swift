//
//  CalendarViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 5.11.2023.
//

import UIKit
import SwiftUI

protocol CalendarViewProtocol: AnyObject { }

class CalendarViewController: BaseViewController {
    var presenter: CalendarPresenterProtocol?
    private var sliderView: SlideView?
    
    private var sliderData = [SlideView.SlideData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
        sliderView = SlideView(pages: 3, delegate: self)
        
        sliderData.append(.init(image: UIImage(named: "info-host"), text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit"))
        sliderData.append(.init(image: UIImage(named: "info-dog"),text: "elit"))
        sliderData.append(.init(image: UIImage(named: "info-cat"), text: "consectetur adipiscing elit"))
        
        prepareUI()
        sliderView?.configureView(with: sliderData)
        
        setupTitle()
    }
    private func setupTitle() {
        let titleLabel = TitleLabel.configurationTitleLabel(withText:"Rezervation", fontSize: 17, textColor: AppColors.primaryColor)
        navigationItem.titleView = titleLabel
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sliderView?.configureView(with: sliderData)
    }
    
    func prepareUI() {
        setupConstraints()
        view.backgroundColor = AppColors.bgColor
    }
    
    private func setupConstraints() {
        guard let sliderView = sliderView else { return }
        view.addSubview(sliderView)
        sliderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sliderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            sliderView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            sliderView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            sliderView.heightAnchor.constraint(equalToConstant: 25.hPercent)
        ])
    }
}

extension CalendarViewController: SlideViewProtocol {
    func currentPageDidChange(to page: Int) {
        UIView.animate(withDuration: 0.7) {
            
        }
    }
}

struct RezervationVC_Previews: PreviewProvider {
    static var previews: some View {
        CalendarViewController().showPreview()
    }
}
