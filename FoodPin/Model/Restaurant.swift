//
//  Restaurant.swift
//  Restaurant
//
//  Created by Андрей Бородкин on 05.08.2021.
//

import Foundation

struct Restaurant: Hashable {
    var name: String
    var type: String
    var location: String
    var image: String
    var isFavourite: Bool
    
    static var all: [Restaurant] = [
        Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "Hong Kong", image: "cafedeadend", isFavourite: false),
            Restaurant(name: "Homei", type: "Cafe", location: "Hong Kong", image: "homei", isFavourite: false),
            Restaurant(name: "Teakha", type: "Tea House", location: "Hong Kong", image: "teakha", isFavourite: false),
            Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "Hong Kong", image: "cafeloisl", isFavourite: false),
        Restaurant(name: "Petite Oyster", type: "French", location: "Hong Kong", image: "petiteoyster", isFavourite: false),
            Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "HongKong", image: "forkee", isFavourite: false),
            Restaurant(name: "Po's Atelier", type: "Bakery", location: "Hong Kong", image: "posatelier", isFavourite: false),
            Restaurant(name: "Bourke Street Backery", type: "Chocolate", location: "Sydney", image: "bourkestreetbakery", isFavourite: false),
            Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "Sydney", image: "haigh", isFavourite: false),
            Restaurant(name: "Palomino Espresso", type: "American / Seafood", location: "Sydney", image: "palomino", isFavourite: false),
            Restaurant(name: "Upstate", type: "American", location: "New York", image: "upstate", isFavourite: false),
            Restaurant(name: "Traif", type: "American", location: "New York", image: "traif", isFavourite: false),
            Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "New York", image: "graham", isFavourite: false),
            Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "NewYork", image: "waffleandwolf", isFavourite: false),
            Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "New York", image: "fiveleaves", isFavourite: false),
            Restaurant(name: "Cafe Lore", type: "Latin American", location: "New York", image: "cafelore", isFavourite: false),
            Restaurant(name: "Confessional", type: "Spanish", location: "New York", image: "confessional", isFavourite: false),
            Restaurant(name: "Barrafina", type: "Spanish", location: "London", image: "barrafina", isFavourite: false),
            Restaurant(name: "Donostia", type: "Spanish", location: "London", image: "donostia", isFavourite: false),
            Restaurant(name: "Royal Oak", type: "British", location: "London", image: "royaloak", isFavourite: false),
            Restaurant(name: "CASK Pub and Kitchen", type: "Thai", location: "London", image: "cask", isFavourite: false)
    ]
    
    init(name: String, type: String, location: String, image: String, isFavourite: Bool) {
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.isFavourite = isFavourite
    }
    
    init() {
        self.init(name: "", type: "", location: "", image: "", isFavourite: false)
    }
}
