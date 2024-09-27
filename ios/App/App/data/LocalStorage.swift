//
//  LocalStorage.swift
//  App
//
//  Created by Shahzaib Ali on 04/08/2024.
//

import Foundation


class LocalStorage {
    // Singleton instance
    static let shared = LocalStorage()
    
    // Private initializer to prevent instantiation
    private init() {}
    
    // Keys
    private enum Keys: String {
        case user_location
    }
    
    // Save string value to UserDefaults
    func saveString(value: String, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    // Retrieve string value from UserDefaults
    func getString(forKey key: String) -> String? {
        return UserDefaults.standard.string(forKey: key)
    }
    
    // Save specific value (example)
    func saveLocation(value: String) {
        saveString(value: value, forKey: Keys.user_location.rawValue)
    }
    
    // Retrieve specific value (example)
    func getLocation() -> String? {
        return getString(forKey: Keys.user_location.rawValue)
    }
}
