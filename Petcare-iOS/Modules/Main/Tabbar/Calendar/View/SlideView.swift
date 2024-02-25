//
//  CarouselView.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 18.02.2024.
//

import UIKit



protocol SlideViewProtocol {
    func currentPageDidChange(to page: Int)
}

final class SlideView: UIView {
    
    struct SlideData {
        let image: UIImage?
        let text: String
    }
    
    // MARK: - Subviews
    private lazy var carouselCollection: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .lightGray
        collectionView.isUserInteractionEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SlideCell.self, forCellWithReuseIdentifier: Constants.CollectionViewCell.slideCell)
        return collectionView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.translatesAutoresizingMaskIntoConstraints = false
        control.numberOfPages = 3
        control.currentPage = 0
        control.isUserInteractionEnabled = false
        control.pageIndicatorTintColor = .gray
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CollectionViewCell.slideCell, for: indexPath) as? SlideCell else { return UICollectionViewCell() }
        
        let image = carouselData[indexPath.row].image
        let text = carouselData[indexPath.row].text
        
        cell.configure(image: image, text: text)
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
        let cellPadding = (frame.width - 300) / 2
        let carouselLayout = UICollectionViewFlowLayout()
        carouselLayout.scrollDirection = .horizontal
        carouselLayout.itemSize = .init(width: 300, height: 400)
        carouselLayout.sectionInset = .init(top: 0, left: cellPadding, bottom: 0, right: cellPadding)
        carouselLayout.minimumLineSpacing = cellPadding * 2
        carouselCollection.collectionViewLayout = carouselLayout
        
        carouselData = data
        carouselCollection.reloadData()
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            carouselCollection.topAnchor.constraint(equalTo: topAnchor),
            carouselCollection.leadingAnchor.constraint(equalTo: leadingAnchor),
            carouselCollection.trailingAnchor.constraint(equalTo: trailingAnchor),
            carouselCollection.heightAnchor.constraint(equalToConstant: 450),
            
            pageControl.topAnchor.constraint(equalTo: carouselCollection.bottomAnchor, constant: 16),
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.widthAnchor.constraint(equalToConstant: 150),
            pageControl.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
