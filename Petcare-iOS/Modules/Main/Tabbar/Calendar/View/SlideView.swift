//
//  CarouselView.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 18.02.2024.
//

import UIKit
import SwiftUI


protocol SlideViewProtocol {
    func currentPageDidChange(to page: Int)
}

final class SlideView: UIView {
    private var timer: Timer?
    
    struct SlideData {
        let image: UIImage?
        let text: String
    }
    
    // MARK: - Subviews
    private lazy var carouselCollection: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.isUserInteractionEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.addShadow(shadowColor: AppColors.bgColor.cgColor)
        collectionView.registerNib(with: Constants.CollectionViewCell.slideCell)
        collectionView.registerCodedCell(with: SlideCell.self)
        return collectionView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.translatesAutoresizingMaskIntoConstraints = false
        control.numberOfPages = 3
        control.currentPage = 0
        control.isUserInteractionEnabled = false
        control.pageIndicatorTintColor = .lightGray
        control.currentPageIndicatorTintColor = AppColors.primaryColor
        return control
    }()
    
    // MARK: - Properties
    private var pages: Int
    private var delegate: SlideViewProtocol?
    private var carouselData = [SlideData]()
    private var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            delegate?.currentPageDidChange(to: currentPage)
        }
    }
    
    init(pages: Int, delegate: SlideViewProtocol?) {
        self.pages = pages
        self.delegate = delegate
        super.init(frame: .zero)
        setupUI()
        startTimer()
    }
    
    deinit {
        timer?.invalidate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(autoSlide), userInfo: nil, repeats: true)
    }
    
    @objc private func autoSlide() {
        let nextPage = (currentPage + 1) % pages
        scrollToPage(nextPage)
    }
    
    private func scrollToPage(_ page: Int) {
        let indexPath = IndexPath(item: page, section: 0)
        carouselCollection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        currentPage = page
    }
}

extension SlideView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carouselData.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellClass: SlideCell.self, indexPath: indexPath)
        let image = carouselData[indexPath.row].image
        let text = carouselData[indexPath.row].text
        
        cell.configure(text: text,image: image!)
        return cell
    }
}


extension SlideView: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = getCurrentPage()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        currentPage = getCurrentPage()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentPage = getCurrentPage()
    }
}

extension SlideView {
    func getCurrentPage() -> Int {
        let visibleRect = CGRect(origin: carouselCollection.contentOffset, size: carouselCollection.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = carouselCollection.indexPathForItem(at: visiblePoint) {
            return visibleIndexPath.row
        }
        
        return currentPage
    }
}

extension SlideView {
    public func setupUI() {
        backgroundColor = .clear
        pageControl.numberOfPages = pages
        addSubview(carouselCollection)
        addSubview(pageControl)
        setupConstraints()
    }
    
    public func configureView(with data: [SlideData]) {
        let carouselLayout = UICollectionViewFlowLayout()
        carouselLayout.scrollDirection = .horizontal
        carouselLayout.itemSize = .init(width: 100.wPercent - 50 , height: 50.wPercent)
        carouselLayout.minimumLineSpacing = 10 * 2
        carouselLayout.sectionInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        carouselCollection.collectionViewLayout = carouselLayout
        
        carouselData = data
        carouselCollection.reloadData()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            carouselCollection.leadingAnchor.constraint(equalTo: leadingAnchor),
            carouselCollection.trailingAnchor.constraint(equalTo: trailingAnchor),
            carouselCollection.topAnchor.constraint(equalTo: topAnchor),
            carouselCollection.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            pageControl.topAnchor.constraint(equalTo: carouselCollection.bottomAnchor,constant: 2.wPercent),
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.widthAnchor.constraint(equalToConstant: 40.wPercent),
            pageControl.heightAnchor.constraint(equalToConstant: 2.wPercent),
        ])
    }
}

extension SlideView {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        carouselCollection.addShadow(shadowColor: AppColors.bgColor.cgColor)
    }
}
