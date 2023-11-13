//
//  OnboardingViewMock.swift
//  Petcare-iOSTests
//
//  Created by Kenan Baylan on 13.11.2023.
//

import Foundation
@testable import Petcare_iOS

final class OnboardingViewMock: OnboardingViewDelegate {
    private var currentPageIndex = 0
    enum Status: Equatable {
        case showOnboarding, showPrevButton, hidePrevButton
        case getPage(Int)
        case setup(buttonTitle: String)
        case displayScreen(index: Int)
        case isPossibleNext(Bool)
    }
    
    private (set) var receivedMessages = [Status]()
    
    func showOnboarding() {
        receivedMessages.append(.showOnboarding)
    }
    
    func setup(buttonTitle: String) {
        receivedMessages.append(.setup(buttonTitle: buttonTitle))
    }
    
    func getPage() -> Int {
        receivedMessages.append(.getPage(currentPageIndex))
        return currentPageIndex
    }
    
    func displayScreen(at index: Int) {
        receivedMessages.append(.displayScreen(index: index))
    }
    
    func isPossibleNext(_ newState: Bool) {
        receivedMessages.append(.isPossibleNext(newState))
    }
    
    func hidePrevButton() {
        receivedMessages.append(.hidePrevButton)
    }
    
    func showPrevButton() {
        receivedMessages.append(.showOnboarding)
    }
    
}
