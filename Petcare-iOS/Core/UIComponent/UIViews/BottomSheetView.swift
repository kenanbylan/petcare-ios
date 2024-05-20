//
//  CustomPickerView.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 13.03.2024.
//

import Foundation
import UIKit

final class BottomSheetView: UIView, UITableViewDelegate, UITableViewDataSource {
    let tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
    var options: [String] = []
    var didSelectOption: ((String) -> Void)?
    var headerTitle: String? = nil
    
    init(frame: CGRect, title: String ) {
        super.init(frame: frame)
        self.headerTitle = title
        setupTableView()
        
        tableView.layer.cornerRadius = 20
        layer.cornerRadius = 20
        
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        addSubview(tableView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.frame = bounds
        clipsToBounds = true
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedOption = options[indexPath.row]
        didSelectOption?(selectedOption)
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerTitle
    }
}
