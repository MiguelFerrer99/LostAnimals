//
//  Cache.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 28/10/2021.
//  Copyright © 2020 Miguel Ferrer Fornali. All rights reserved.
//

import Foundation

struct Cache {
    // MARK: - Enums
    enum key: String {
        case logged,
             onboardingDone
    }
    
    // MARK: - Static functions
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
    
    static func printAll() {
        print("[CacheHandler] Print Userdefaults:")
        print("------------------------------------")
        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
            print("\(key) = \(value)")
        }
        print("------------------------------------")
    }
    
    static func clear() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
    static func logOut() {
        Cache.set(.logged, false)
        User.shared = nil
    }
}
