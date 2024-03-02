//
//  ScrollableContentViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 2.03.2024.
//

import UIKit

class ScrollableContentViewController: UIViewController {
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        // Set these properties to a default value that suits you:
        scrollView.keyboardDismissMode = .interactiveWithAccessory
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()

    /// The `KeyboardAvoidanceViewController`'s `contentView`. Use this property when adding subviews to this ViewController / View.
    private(set) lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    /// The keyboard dismiss mode as defined on `UIScrollView`. This is a mirror of the property with the same name on the underlying `UIScrollView`.
    var keyboardDismissMode: UIScrollView.KeyboardDismissMode {
        get { scrollView.keyboardDismissMode }
        set { scrollView.keyboardDismissMode = newValue }
    }

    /// The strategy for vertical bounce as defined on `UIScrollView`. This is a mirror of the property with the same name on the underlying `UIScrollView`.
    var alwaysBounceVertical: Bool {
        get { scrollView.alwaysBounceVertical }
        set { scrollView.alwaysBounceVertical = newValue }
    }

    private var adjustContentInsetInsteadOfSafeArea: Bool = false

    /// Initiate a `KeyboardAvoidanceViewController` with the option to adjust the underlying `UIScrollView`'s content inset instead of the safe area when the keyboard appears/disappears.
    ///
    /// - Parameter adjustContentInsetInsteadOfSafeArea: If the underlying `UIScrollView`'s content inset should be adjusted instead of the safe area when the keyboard appears/disappears.
    convenience init(adjustContentInsetInsteadOfSafeArea: Bool = false) {
        self.init()
        self.adjustContentInsetInsteadOfSafeArea = adjustContentInsetInsteadOfSafeArea
    }

    override func loadView() {
        view = UIView()

        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.topAnchor
            ),
            contentView.leadingAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.leadingAnchor
            ),
            contentView.trailingAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.trailingAnchor
            ),
            contentView.bottomAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.bottomAnchor
            ),
        ])

        let heightConstraint = scrollView.contentLayoutGuide.heightAnchor.constraint(
            greaterThanOrEqualTo: scrollView.safeAreaLayoutGuide.heightAnchor
        )
        // Set the UIScrollView's content height constraint priority a little bit lower than `.required`.
        // That way we avoid any initial layout conflicts and/or any other `.required` constraints on `contentView`.
        // We want the `contentView` to take up as much space as possible,
        // so we can easily place content all over the screen (represented by this UIViewController).
        heightConstraint.priority = .required - 1

        NSLayoutConstraint.activate([
            scrollView.contentLayoutGuide.widthAnchor.constraint(
                equalTo: scrollView.frameLayoutGuide.widthAnchor
            ),
            heightConstraint
        ])
    }
}

extension ScrollableContentViewController {

    /// A simple utility/convenience method to pin a subview to all edges of the `contentView`.
    func pinToContentView(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(view)

        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
