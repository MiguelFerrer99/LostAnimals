//
//  Aray.swift
//  test_ios-davidalhambra
//
//  Created by David García Alhambra on 16/5/21.
//

import Foundation

extension RangeReplaceableCollection where Element: Equatable {
  mutating func addOrReplace(contentsOf elements: [Element]) {
    elements.forEach { element in
      if let index = self.firstIndex(of: element) {
        self.replaceSubrange(index...index, with: [element])
      } else {
        self.append(element)
      }
    }
  }
}
