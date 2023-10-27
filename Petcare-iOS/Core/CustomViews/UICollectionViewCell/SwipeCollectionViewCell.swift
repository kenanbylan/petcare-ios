//
//  SwipeCollectionViewCell.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 18.10.2023.
//

import UIKit

class SwipeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SwipeCollectionViewCell"
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    func setupSwipe(data: OnboardingModel){
//        self.imageView.image = UIImage(named: data.image)
//        self.titleLabel.text = data.headline
//        self.descriptionLabel.text = data.subheadline
    }
}
