//
//  DateListInfoViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 23.04.2024.
//

import UIKit

protocol DateListInfoViewProtocol: AnyObject { }

enum SectionDateList {
    case main
}

final class DateListInfoViewController: UIViewController {
    var presenter: DateListInfoPresenterProtocol?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.allowsSelection = true
        return collectionView
    }()
    
    var dataSource: UICollectionViewDiffableDataSource<SectionDateList, ListItem>!
    var dataSourceSnapshot = NSDiffableDataSourceSnapshot<SectionDateList, ListItem>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        view.backgroundColor = AppColors.bgColor
        collectionView.delegate = self
        
        prepareTitleLabel()
        prepareCollectionView()
    }
    
    private func prepareCollectionView() {
        let layoutConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: listLayout)
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor ),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        prepareDataSource()
        prepareSnapshot()
    }
    
    private func prepareSnapshot() {
        dataSourceSnapshot.appendSections([.main])
        dataSource.apply(dataSourceSnapshot)
        
        var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<ListItem>()
        for headerItem in modelObjects {
            let headerListItem = ListItem.header(headerItem)
            sectionSnapshot.append([headerListItem])
            
            let symbolListItemArray = headerItem.symbols.map { ListItem.symbol($0) }
            sectionSnapshot.append(symbolListItemArray, to: headerListItem)
            sectionSnapshot.expand([headerListItem])
        }
        
        dataSource.apply(sectionSnapshot, to: .main, animatingDifferences: false)
    }
    
    private func prepareDataSource() {
        let headerCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, HeaderItem> {
            (cell, indexPath, headerItem) in
            var content = cell.defaultContentConfiguration()
            content.text = headerItem.title
            cell.contentConfiguration = content
            
            let headerDisclosureOption = UICellAccessory.OutlineDisclosureOptions(style: .header)
            cell.accessories = [.outlineDisclosure(options:headerDisclosureOption)]
        }
        
        let symbolCellRegistration = UICollectionView.CellRegistration<CustomDateCollectionViewCell, DateList> {
            (cell, indexPath, symbolItem) in
            cell.configure(with: symbolItem)
            cell.checkBoxSwitch.addTarget(self, action: #selector(self.switchValueChanged(_:)), for: .valueChanged)
        }
        
        dataSource = UICollectionViewDiffableDataSource<SectionDateList, ListItem>(collectionView: collectionView) {
            (collectionView, indexPath, listItem) -> UICollectionViewCell? in
            switch listItem {
            case .header(let headerItem):
                let cell = collectionView.dequeueConfiguredReusableCell(using: headerCellRegistration,
                                                                        for: indexPath,
                                                                        item: headerItem)
                return cell
                
            case .symbol(let symbolItem):
                let cell = collectionView.dequeueConfiguredReusableCell(using: symbolCellRegistration,
                                                                        for: indexPath,
                                                                        item: symbolItem)
                return cell
            }
        }
    }
    
    private func prepareTitleLabel() {
        let titleLabel = TitleLabel.configurationTitleLabel(withText: "Date List Change's", fontSize: 17, textColor: AppColors.primaryColor)
        navigationItem.titleView = titleLabel
    }
    
    @objc private func switchValueChanged(_ sender: UISwitch) {
        guard let cell = sender.superview?.superview as? CustomDateCollectionViewCell,
              let indexPath = collectionView.indexPath(for: cell),
              let item = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        
        if case .symbol(var dateList) = item {
            dateList.isSelected = sender.isOn
            
            // Yeni bir snapshot oluştur
            var snapshot = dataSource.snapshot()
            
            // Değişiklik yapılan öğeyi güncelle
            snapshot.reloadItems([item])
            
            // Güncellenmiş snapshot'ı dataSource'a uygula
            dataSource.apply(snapshot)
        }
    }
}

extension DateListInfoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard let selectedItem = dataSource.itemIdentifier(for: indexPath) else {
            collectionView.deselectItem(at: indexPath, animated: true)
            return
        }
        
        print("selectedItem \(selectedItem)")
    }
}
