//
//  OnboardingViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 14.10.2023.
//

import UIKit

protocol OnboardingViewInterface: AnyObject {
    func prepareUI()
    func setTitle(_ title: String)
}

class OnboardingViewController: UIViewController {
    var presenter: OnboardingPresenterInterface?
    
    //MARK: - UIProperty
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slidesCount: Int!
    
    //MARK: Variable
    var currentPageNumber = 0 {
        didSet {
            if currentPageNumber == slidesCount - 1 {
                nextButton.setTitle("Get Started", for: .normal)
            } else { nextButton.setTitle("Next", for: .normal) }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.load()
        initViews()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(SwipeCollectionViewCell.self, forCellWithReuseIdentifier: SwipeCollectionViewCell.identifier)
        self.slidesCount = presenter?.swipeData.count
        self.pageControl.numberOfPages = slidesCount
    }
    
}

extension OnboardingViewController : OnboardingViewInterface {
    
    func prepareUI() {
        view.backgroundColor = .red
    }
    
    func setTitle(_ title: String) {
        navigationItem.title = title
    }
}

//MARK: Buttons
extension OnboardingViewController {
    
    //MARK: UIActions
    @IBAction func NextButtonTapped(_ sender: Any) {
        
        if currentPageNumber == slidesCount - 1 {
            
            //MARK: NAVİGATE TO LOGİN AND REGİSTER
            //            let homeController = storyboard?.instantiateViewController(identifier: "toHomeNC") as! UINavigationController
            //            homeController.modalPresentationStyle = .fullScreen
            //            homeController.modalTransitionStyle = .coverVertical
            //            present(homeController, animated: true)
            //

        } else {
            currentPageNumber += 1
            pageControl.currentPage += 1
            let indexPath = IndexPath(item: currentPageNumber, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}


//MARK: UI Drawing
extension OnboardingViewController: UICollectionViewDelegate {
    private func initViews() { }
    
}

extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
    }
    
    func scrollViewDidzEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        let currentPage = Int(scrollView.contentOffset.x) / Int(width)
        pageControl.currentPage = currentPageNumber
        currentPageNumber = currentPage
    }
}

extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.swipeData.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SwipeCollectionViewCell.identifier, for: indexPath) as! SwipeCollectionViewCell
        if let swipeData = presenter?.swipeData, indexPath.row < swipeData.count {
            let item = swipeData[indexPath.row]
            cell.setupSwipe(data: item)
        } else {
            print("Data is nil or index is out of bounds.")
        }
        
        return cell
    }
}
