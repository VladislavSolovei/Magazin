//
//  Green.swift
//  Magazin
//
//  Created by Sergey Shinkarenko on 21.05.21.
//

import Foundation

class Shop {
    var items: [String] = []
    var storage: [String] = []
    var closed: Bool = true
    var onShopClosed: () -> () = {}

    init() {
        updateWorkingStatus()
        if let savedStorage = UserDefaults.standard.array(forKey: "ShopStorage") as? [String] {
            storage = savedStorage
        }
        if let savedItems = UserDefaults.standard.array(forKey: "ShopShelf") as? [String] {
            items = savedItems
        }
    }

    func sell() {
        guard items.count > 0 else {
            onShopClosed()
            return
        }
        items.remove(at: 0)
        UserDefaults.standard.set(items, forKey: "ShopShelf")
        if items.isEmpty {
            addItemsFromStorage()
        }
    }

    func moveItemsToShelf() {
        items.append(contentsOf: storage)
        storage = []
        UserDefaults.standard.removeObject(forKey: "ShopStorage")
        UserDefaults.standard.set(items, forKey: "ShopShelf")
    }

    private func addItemsFromStorage() {
        if storage.isEmpty {
            updateWorkingStatus()
        } else {
            items.append(storage[0])
            UserDefaults.standard.set(items, forKey: "ShopShelf")
            storage.remove(at: 0)
            UserDefaults.standard.set(items, forKey: "ShopStorage")
        }
    }

    private func updateWorkingStatus() {
        if items.isEmpty {
            closed = true
            onShopClosed()
        } else {
            closed = false
        }
    }
}
