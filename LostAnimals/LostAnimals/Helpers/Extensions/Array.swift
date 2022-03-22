//
//  Aray.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 28/10/2021.
//  Copyright © 2020 Miguel Ferrer Fornali. All rights reserved.
//

// MARK: - Functions
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
