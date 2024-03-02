//
//  CalendarViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 5.11.2023.
//

import UIKit

protocol CalendarViewProtocol: AnyObject {
    
}

class CalendarViewController: BaseViewController {
    var presenter: CalendarPresenterProtocol?
    private var sliderView: SlideView?
    
    private var sliderData = [SlideView.SlideData]()
    private let backgroundColors: [UIColor] = [#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), #colorLiteral(red: 0.4826081395, green: 0.04436998069, blue: 0.2024421096, alpha: 1), #colorLiteral(red: 0.1728022993, green: 0.42700845, blue: 0.3964217603, alpha: 1)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
        sliderView = SlideView(pages: 3, delegate: self)
        sliderData.append(.init(image: UIImage(named: "dog"), text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit"))
        sliderData.append(.init(image: UIImage(named: "pati"), text: "elit"))
        sliderData.append(.init(image: UIImage(named: "cat"), text: "consectetur adipiscing elit"))

        prepareUI()
        
        sliderView?.configureView(with: sliderData)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sliderView?.configureView(with: sliderData)
    }
    
    func prepareUI() {
        view.backgroundColor = backgroundColors.first
        setupConstraints()
    }
    
    private func setupConstraints() {
        guard let sliderView = sliderView else { return }
        view.addSubview(sliderView)
        sliderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sliderView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            sliderView.leftAnchor.constraint(equalTo: view.leftAnchor),
            sliderView.rightAnchor.constraint(equalTo: view.rightAnchor),
            sliderView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension CalendarViewController: SlideViewProtocol {
    func currentPageDidChange(to page: Int) {
        UIView.animate(withDuration: 0.7) {
            self.view.backgroundColor = self.backgroundColors[page]
        }
    }
    
    
}
