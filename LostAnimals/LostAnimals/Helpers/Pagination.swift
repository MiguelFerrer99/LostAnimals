//
//  Pagination.swift
//  Template
//
//  Created by Toni García Alhambra on 11/03/2020.
//  Copyright © 2020 Rudo. All rights reserved.
//

import Foundation

class Pagination<T> {
  typealias Item = T
  
  fileprivate var items = [Item]()
  fileprivate var pageNumber: Int = 1
  
  var page: Int { return pageNumber }
  var numberOfItems: Int { return items.count }
  
  var hasNextPage: Bool = true
  var isCalling: Bool = false
  var count: Int = 0
  
  var isEmpty: Bool {
    numberOfItems == 0
  }
  
  /// It resets the pagination.
  func resetAndRemove() {
    pageNumber   = 1
    hasNextPage  = true
    removeAllItems()
  }
  
  func resetPage() {
    pageNumber   = 1
    hasNextPage  = true
  }
  
  /// Set the items in the correct position of the array.
  ///
  /// If it's the first page the items will be replaced, else the items will be appended.
  ///
  /// - Parameter items: The items to append or fill the array.
  func setItems(_ items: [Item]) {
    if pageNumber == 1 {
      self.items = items
    } else {
      self.items.append(contentsOf: items)
    }
    
    pageNumber += 1
  }
  
  /// It returns a boolean that means if the table needs to call the service.
  ///
  /// - Parameter currentIndex: The current index of the table.
  /// - Returns: A boolean that that means if the table needs to call the service.
  func needsToReload(currentIndex: Int) -> Bool {
    return numberOfItems - currentIndex < 5
  }
  
  /// It return the item at given position.
  ///
  /// - Parameter index: The position of the array.
  /// - Returns: The item.
  func getItemAt(index: Int) -> Item? {
    return items.count > index ? items[index] : nil
  }
  
  /// It returns all the items.
  ///
  /// - Returns: All the items in the array.
  func getitems() -> [Item] {
    return items
  }
  
  /// Removes the items in the items array.
  ///
  /// - Parameters:
  ///   - indexes: An array containing the indexes of which items must be deleted.
  func removeItems(at indexes: [Int]) {
    indexes.forEach { (index) in
      items.remove(at: index)
    }
  }
  
  /// Remove all items in the items array.
  func removeAllItems() {
    items.removeAll()
  }
}

class Paginable<T: Codable>: Codable {
  var count: Int?
  
  var next,
      previous: String?
  
  var results = [T]()
}
