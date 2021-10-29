//
//  Cache.swift
//  Template
//
//  Created by Toni García Alhambra on 11/03/2020.
//  Copyright © 2020 Rudo. All rights reserved.
//

import Foundation

struct Cache {
  enum key: String {
    case refresh_token,
         access_token,
         logged,
         userID
  }
  
  static func set(_ key: key, _ value: Any?) {
    UserDefaults.standard.set(value, forKey: key.rawValue)
  }
  
  static func get(stringFor: key) -> String? {
    return UserDefaults.standard.string(forKey: stringFor.rawValue)
  }
  
  static func get(intFor: key) -> Int {
    return UserDefaults.standard.integer(forKey: intFor.rawValue)
  }
  
  static func get(doubleFor: key) -> Double {
    return UserDefaults.standard.double(forKey: doubleFor.rawValue)
  }
  
  static func get(floatFor: key) -> Float {
    return UserDefaults.standard.float(forKey: floatFor.rawValue)
  }
  
  static func get(boolFor: key) -> Bool {
    return UserDefaults.standard.bool(forKey: boolFor.rawValue)
  }
  
  static func get(arrayFor: key) -> [Any]? {
    return UserDefaults.standard.array(forKey: arrayFor.rawValue)
  }
  
  static func get(anyFor: key) -> Any? {
    return UserDefaults.standard.object(forKey: anyFor.rawValue) as Any
  }
  
  static func get(dictionaryArrayFor: key) -> [String: [Any]]? {
    return UserDefaults.standard.dictionary(forKey: dictionaryArrayFor.rawValue) as? [String : [Any]]
  }
  
  static func get(dictionaryFor: key) -> [String: Any]? {
    return UserDefaults.standard.dictionary(forKey: dictionaryFor.rawValue)
  }
  
  static func printAll(){
    print("[CacheHandler] Print Userdefaults:")
    print("------------------------------------")
    for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
      print("\(key) = \(value)")
    }
    print("------------------------------------")
  }
  
  static func clear(){
    let defaults = UserDefaults.standard
    let dictionary = defaults.dictionaryRepresentation()
    dictionary.keys.forEach { key in
      defaults.removeObject(forKey: key)
    }
  }
  
  static func logOut() {
    Cache.set(.logged, false)
    Cache.set(.userID, nil)
  }
}
