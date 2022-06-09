//
//  AppData.swift
//  Rawdah
//
//  Created by Sapar Jumabekov on 08.06.2022.
//

import CoreLocation

struct AppData {
    
    // MARK: - General
    @AppDataStorage(key: "isFirstTime_key", defaultValue: true)
    static var isFirstTime: Bool
}

@propertyWrapper
struct AppDataStorage<T: Codable> {
    private let key: String
    private let defaultValue: T
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            guard let data = UserDefaults.standard.object(forKey: key) as? Data else {
                return defaultValue
            }
            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
