//
//  DateListInfoViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 23.04.2024.
//

import UIKit

//protocol DateListInfoViewProtocol: AnyObject { }
//
//enum SectionDateList {
//    case main
//}
//
//final class DateListInfoViewController: UIViewController {
//    var presenter: DateListInfoPresenterProtocol?
//
//    lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.allowsSelection = true
//        return collectionView
//    }()
//
//    var dataSource: UICollectionViewDiffableDataSource<SectionDateList, ListItem>!
//    var dataSourceSnapshot = NSDiffableDataSourceSnapshot<SectionDateList, ListItem>()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        presenter?.viewDidLoad()
//        view.backgroundColor = AppColors.bgColor
//        collectionView.delegate = self
//
//        prepareTitleLabel()
//        prepareCollectionView()
//    }
//
//    private func prepareCollectionView() {
//        let layoutConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
//        let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
//
//        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: listLayout)
//        view.addSubview(collectionView)
//
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            collectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
//            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor ),
//            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//        ])
//
//        prepareDataSource()
//        prepareSnapshot()
//    }
//
//    private func prepareSnapshot() {
//        dataSourceSnapshot.appendSections([.main])
//        dataSource.apply(dataSourceSnapshot)
//
//        var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<ListItem>()
//        for headerItem in modelObjects {
//            let headerListItem = ListItem.header(headerItem)
//            sectionSnapshot.append([headerListItem])
//
//            let symbolListItemArray = headerItem.symbols.map { ListItem.symbol($0) }
//            sectionSnapshot.append(symbolListItemArray, to: headerListItem)
//            sectionSnapshot.expand([headerListItem])
//        }
//
//        dataSource.apply(sectionSnapshot, to: .main, animatingDifferences: false)
//    }
//
//    private func prepareDataSource() {
//        let headerCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, HeaderItem> {
//            (cell, indexPath, headerItem) in
//            var content = cell.defaultContentConfiguration()
//            content.text = headerItem.title
//            cell.contentConfiguration = content
//
//            let headerDisclosureOption = UICellAccessory.OutlineDisclosureOptions(style: .header)
//            cell.accessories = [.outlineDisclosure(options:headerDisclosureOption)]
//        }
//
//        let symbolCellRegistration = UICollectionView.CellRegistration<CustomDateCollectionViewCell, DateList> {
//            (cell, indexPath, symbolItem) in
//            cell.configure(with: symbolItem)
//            cell.checkBoxSwitch.addTarget(self, action: #selector(self.switchValueChanged(_:)), for: .valueChanged)
//        }
//
//        dataSource = UICollectionViewDiffableDataSource<SectionDateList, ListItem>(collectionView: collectionView) {
//            (collectionView, indexPath, listItem) -> UICollectionViewCell? in
//            switch listItem {
//            case .header(let headerItem):
//                let cell = collectionView.dequeueConfiguredReusableCell(using: headerCellRegistration,
//                                                                        for: indexPath,
//                                                                        item: headerItem)
//                return cell
//
//            case .symbol(let symbolItem):
//                let cell = collectionView.dequeueConfiguredReusableCell(using: symbolCellRegistration,
//                                                                        for: indexPath,
//                                                                        item: symbolItem)
//                return cell
//            }
//        }
//    }
//
//    private func prepareTitleLabel() {
//        let titleLabel = TitleLabel.configurationTitleLabel(withText: "Date List Change's", fontSize: 17, textColor: AppColors.primaryColor)
//        navigationItem.titleView = titleLabel
//    }
//
//    @objc private func switchValueChanged(_ sender: UISwitch) {
//        guard let cell = sender.superview?.superview as? CustomDateCollectionViewCell,
//              let indexPath = collectionView.indexPath(for: cell),
//              let item = dataSource.itemIdentifier(for: indexPath) else {
//            return
//        }
//
//        if case .symbol(var dateList) = item {
//            dateList.isSelected = sender.isOn
//
//            // Yeni bir snapshot oluştur
//            var snapshot = dataSource.snapshot()
//
//            // Değişiklik yapılan öğeyi güncelle
//            snapshot.reloadItems([item])
//
//            // Güncellenmiş snapshot'ı dataSource'a uygula
//            dataSource.apply(snapshot)
//        }
//    }
//}
//
//extension DateListInfoViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView,
//                        didSelectItemAt indexPath: IndexPath) {
//        guard let selectedItem = dataSource.itemIdentifier(for: indexPath) else {
//            collectionView.deselectItem(at: indexPath, animated: true)
//            return
//        }
//
//        print("selectedItem \(selectedItem)")
//    }
//}
//


import UIKit

struct Item: Hashable {
    let id = UUID()
    let title: String
    let subItems: [Item]
    var status: Bool
}

typealias CollectionDataSource = UICollectionViewDiffableDataSource<Int, Item>

class CustomCell: UICollectionViewCell {
    let timeLabel = UILabel()
    let switchControl = UISwitch()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(timeLabel)
        contentView.addSubview(switchControl)
        
        // Configure time label
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        // Configure switch control
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        switchControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        switchControl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DateListInfoViewController: UIViewController {
    var presenter: DateListInfoPresenterProtocol?
    
    private let data: [Item] = {
        return [
            
            Item(title: "Salı",
                     subItems: [Item(title: "Swift", subItems: [],status: true),
                                Item(title: "C++", subItems: [], status: true),
                                Item(title: "C#", subItems: [],status: true)],
                     status: true
                     
                    ),
            Item(title: "Pazartesi",
                     subItems: [Item(title: "Swift", subItems: [],status: true),
                                Item(title: "C++", subItems: [], status: true),
                                Item(title: "C#", subItems: [],status: true)],
                     status: true
                     
                    ),
            Item(title: "Cuma",
                     subItems: [Item(title: "Swift", subItems: [],status: true),
                                Item(title: "C++", subItems: [], status: true),
                                Item(title: "C#", subItems: [],status: true)],
                     status: true
                     
                    ),
        ]
    }()
    
    private lazy var collectionView: UICollectionView = {
        let listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .systemGroupedBackground
        return collectionView
    }()
    
    lazy var datasource: CollectionDataSource = {
        let parentItemCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Item> { cell, indexPath, model in
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = model.title
            contentConfiguration.textProperties.font = .preferredFont(forTextStyle: .headline)
            cell.contentConfiguration = contentConfiguration
            
            let disclosureOptions = UICellAccessory.OutlineDisclosureOptions(style: .header)
            cell.accessories = [.outlineDisclosure(options: disclosureOptions)]
        }
        
        let subItemsCellRegistration = UICollectionView.CellRegistration<CustomCell, Item> { cell, indexPath, model in
            var contentConfiguration = UIListContentConfiguration.subtitleCell()
            contentConfiguration.text = model.title
            contentConfiguration.textProperties.font = .preferredFont(forTextStyle: .subheadline)
            contentConfiguration.textProperties.color = .secondaryLabel
            cell.contentConfiguration = contentConfiguration
            
            // Configure switch
            cell.switchControl.addTarget(self, action: #selector(self.switchValueChanged(_:)), for: .valueChanged)
            // Update switch state based on model status
            cell.switchControl.isOn = model.status
            // Disable switch if time is 9:00 AM
            cell.switchControl.isEnabled = !self.isTimeEqualToNineAM()
            // Update time label
            cell.timeLabel.text = self.getTimeLabelText()
        }
        
        let datasource = CollectionDataSource(collectionView: collectionView) { collectionView, indexPath, model in
            return collectionView.dequeueConfiguredReusableCell(using: subItemsCellRegistration,
                                                                for: indexPath,
                                                                item: model)
        }
        
        return datasource
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        
        let firstParentItem = data.first!
        let subItems = data.first!.subItems
        
        var snapshot = NSDiffableDataSourceSectionSnapshot<Item>()
        snapshot.append([firstParentItem], to: nil)
        snapshot.append(subItems, to: firstParentItem)
        datasource.apply(snapshot, to: 0)
    }
    
    // Function to check if current time is 9:00 AM
    func isTimeEqualToNineAM() -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let currentTime = formatter.string(from: Date())
        return currentTime == "09:00"
    }
    
    // Function to get time label text
    func getTimeLabelText() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: Date())
    }
    
    @objc func switchValueChanged(_ sender: UISwitch) {
        guard let indexPath = collectionView.indexPath(for: sender.superview as! UICollectionViewCell) else {
            return
        }
        var snapshot = datasource.snapshot()
        if var item = datasource.itemIdentifier(for: indexPath) {
            item.status = sender.isOn
            snapshot.reloadItems([item])
            datasource.apply(snapshot, animatingDifferences: true)
        }
    }
}
