//
//  Container.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 28/10/2021.
//  Copyright © 2020 Miguel Ferrer Fornali. All rights reserved.
//

import Foundation

class Container {
	static let shared = Container()
}

extension Container {
  func loginBuilder() -> LoginBuilder {
    return LoginBuilder()
  }
  
  func scrollViewExampleBuilder() -> ScrollViewExampleBuilder {
    return ScrollViewExampleBuilder()
  }
  
  func startupBuilder() -> StartupBuilder {
    return StartupBuilder()
  }
}
