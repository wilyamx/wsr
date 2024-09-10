//
//  WSREChatRoomListViewController.swift
//  WSRExample
//
//  Created by William S. Rena on 9/9/24.
//  Copyright © 2024 Personal Use Only. All rights reserved.
//

import UIKit
import WSRComponents
import WSRUtils
import SuperEasyLayout

class WSREChatRoomListViewController: WSREViewController {
    private typealias Section = WSREChatRoomListViewModel.Section
    private typealias Item = WSREChatRoomListViewModel.Item
    private typealias ItemInfo = WSREChatRoomListViewModel.ItemInfo
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    private var dataSource: DataSource?

    private let refreshControl = {
        let view = UIRefreshControl()
        view.tintColor = .accent
        return view
    }()
    
    private lazy var searchBarView = {
        let view = WSRSearchBarView()
        view.borderColor = .accentSecondary
        view.imageTintColor = .accent
        view.placeholderColor = .text
        return view
    }()

    private lazy var layout: UICollectionViewCompositionalLayout = {
        UICollectionViewCompositionalLayout { [weak self] index, _ in
            guard let self, let sections = dataSource?.snapshot().sectionIdentifiers else { fatalError() }

            switch sections[index] {
            case .myRooms: return getMyRoomsSectionLayout()
            case .otherRooms: return getMyRoomsSectionLayout()
            case .whole: return getWholeSectionLayout()
            }
        }
    }()

    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundView = nil
        view.backgroundColor = .white
        view.refreshControl = refreshControl

        WSRENoDataCollectionViewCell.registerCell(to: view)
        WSREChatRoomListCollectionViewCell.registerCell(to: view)
        WSREChatRoomListHeaderCollectionReusableView.registerView(to: view)
        return view
    }()
    
    let viewModel = WSREChatRoomListViewModel()
    
    // MARK: - View Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Task {
            await load()
        }
    }
    
    // MARK: - Setups
    
    override func setupNavigation() {
        title = "Chat Room List"
    }

    override func setupLayout() {
        view.backgroundColor = .accent
        
        addSubviews([
            searchBarView,
            collectionView,
        ])
    }
    
    override func setupConstraints() {
        searchBarView.left == view.left
        searchBarView.right == view.right
        searchBarView.top == view.topMargin + 10
        
        collectionView.left == view.left
        collectionView.right == view.right
        collectionView.top == searchBarView.bottom + 8
        collectionView.bottom == view.bottom
    }
    
    override func setupActions() {
        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
    }
    
    override func setupBindings() {
        viewModel.$items
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                self?.apply(items)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Private Methods
    
    private func load() async {
        await viewModel.load()
        //await viewModel.loadEmptyRooms()
    }
    
    // MARK: - Actions
    
    @objc
    private func didPullToRefresh(_ sender: UIRefreshControl) {
        Task { await load() }
        refreshControl.endRefreshing()
    }
}

// MARK: - Collection Layout

extension WSREChatRoomListViewController {
    private func getMyRoomsSectionLayout() -> NSCollectionLayoutSection {
        let unitSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(70))
        let item = NSCollectionLayoutItem(layoutSize: unitSize)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: unitSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)),
                elementKind: WSREChatRoomListHeaderCollectionReusableView.viewOfKind,
                alignment: .top
            )
        ]
        return section
    }

    private func getWholeSectionLayout() -> NSCollectionLayoutSection {
        let unitSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: unitSize)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: unitSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}

// MARK: - Set View Based on Data

extension WSREChatRoomListViewController {
    private func apply(_ items: [Section: [Item]]) {
        guard !items.isEmpty else { return }

        var snapshot = Snapshot()
        snapshot.appendSections(items.keys.sorted())

        for (section, subitems) in items {
            snapshot.appendItems(subitems, toSection: section)
        }

        if let dataSource {
            dataSource.apply(snapshot, animatingDifferences: true)
        } else {
            dataSource = DataSource(
                collectionView: collectionView,
                cellProvider: { [weak self] collectionView, indexPath, itemIdentifier in
                    switch itemIdentifier {
                    case .room(let info): self?.getRoomCell(at: indexPath, item: info)
                    case .noData: self?.getNoDataCell(at: indexPath)
                    }
                })
            dataSource?.supplementaryViewProvider = { [weak self] in
                switch $1 {
                case WSREChatRoomListHeaderCollectionReusableView.viewOfKind:
                    self?.getHeader(at: $2)
                default:
                    fatalError()
                }
            }
            if #available(iOS 15.0, *) {
                dataSource?.applySnapshotUsingReloadData(snapshot)
            } else {
                dataSource?.apply(snapshot)
            }
        }
    }

    private func getHeader(at indexPath: IndexPath) -> WSREChatRoomListHeaderCollectionReusableView {
        let view = WSREChatRoomListHeaderCollectionReusableView.dequeueView(from: collectionView, for: indexPath)

        switch dataSource?.snapshot().sectionIdentifiers[indexPath.section] {
        case .myRooms: view.title = "MY ROOMS"
        case .otherRooms: view.title = "OTHER ROOMS"
        default: break
        }

        return view
    }

    private func getRoomCell(at indexPath: IndexPath, item: ItemInfo) -> WSREChatRoomListCollectionViewCell {
        let cell = WSREChatRoomListCollectionViewCell.dequeueCell(from: collectionView, for: indexPath)
        cell.name = item.name
        cell.preview = item.hasPassword ? "Private Chat - Password Protected" : item.preview
        cell.tapHandlerAsync = { _ in
            wsrLogger.info(message: "Selected Item: \(item.name)")
        }
        return cell
    }

    private func getNoDataCell(at indexPath: IndexPath) -> WSRENoDataCollectionViewCell {
        WSRENoDataCollectionViewCell.dequeueCell(from: collectionView, for: indexPath)
    }
}
