//
//  WSREChatRoomListViewModel.swift
//  WSRExample
//
//  Created by William S. Rena on 9/9/24.
//  Copyright © 2024 Personal Use Only. All rights reserved.
//

import Foundation

final class WSREChatRoomListViewModel {
    enum Section: Int, Hashable, Comparable  {
        static func < (lhs: Self, rhs: Self) -> Bool {
            lhs.rawValue < rhs.rawValue
        }

        case myRooms = 0
        case otherRooms
        case whole
    }

    enum Item: Hashable {
        case noData
        case room(ItemInfo)
    }

    struct ItemInfo: Hashable, Codable {
        static func == (lhs: ItemInfo, rhs: ItemInfo) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        var roomId: Int
        var name: String
        var preview: String
        var hasPassword: Bool
        var imageUrlString: String
    }

    @Published var items: [Section: [Item]] = [:]
    
    private var itemsDataSource: [Section: [Item]] = [:]
    
    func load() async {
        items = [
            .myRooms: [
                .room(ItemInfo(roomId: 100, name: "Lorem", preview: "Lorem: Ipsum dolor",
                               hasPassword: false, imageUrlString: "")),
                .room(ItemInfo(roomId: 101, name: "Consectetur", preview: "Consectetur: adipiscing elitr",
                               hasPassword: false, imageUrlString: "")),
                .room(ItemInfo(roomId: 102, name: "Veniam", preview: "Veniam: quis nostrud exercitation",
                               hasPassword: false, imageUrlString: "")),
                .room(ItemInfo(roomId: 103, name: "Exercitation", preview: "Exercitation: ullamco laboris nisi utr",
                               hasPassword: false, imageUrlString: "")),
                .room(ItemInfo(roomId: 104, name: "Duis", preview: "Duis: aute irure dolor in",
                               hasPassword: false, imageUrlString: ""))
            ],
            .otherRooms: [
                .room(ItemInfo(roomId: 200, name: "Duis", preview: "Duis: aute irure dolor in",
                               hasPassword: false, imageUrlString: "")),
                .room(ItemInfo(roomId: 201, name: "Exercitation", preview: "Exercitation: ullamco laboris nisi utr",
                               hasPassword: false, imageUrlString: "")),
                .room(ItemInfo(roomId: 202, name: "Veniam", preview: "Veniam: quis nostrud exercitation",
                               hasPassword: false, imageUrlString: "")),
                .room(ItemInfo(roomId: 203, name: "Consectetur", preview: "Consectetur: adipiscing elitr",
                               hasPassword: false, imageUrlString: "")),
                .room(ItemInfo(roomId: 204, name: "Lorem", preview: "Lorem: Ipsum dolor",
                               hasPassword: false, imageUrlString: ""))
            ]
        ]

        itemsDataSource = items
    }
    
    func filterByName(searchKey: String) {
        guard !searchKey.isEmpty
        else {
            items = itemsDataSource
            return
        }
        guard let myRooms = itemsDataSource[.myRooms],
              let otherRooms = itemsDataSource[.otherRooms]
        else { return }

        items = [
            .myRooms: myRooms.filter({
                if case .room(let itemInfo) = $0 {
                    return itemInfo.name.lowercased().contains(searchKey.lowercased())
                }
                return false
            }),
            .otherRooms: otherRooms.filter({
                if case .room(let itemInfo) = $0 {
                    return itemInfo.name.lowercased().contains(searchKey.lowercased())
                }
                return false
            })
        ]
    }

    func loadEmptyRooms() async {
        items = [
            .whole: [.noData]
        ]
    }
}
