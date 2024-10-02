//
//  Config.swift
//  RidesSwiftUI_Storyboard
//
//  Created by macbook pro on 2024-10-01.
//

import Foundation

enum Config {
    private enum Keys {
        static let apiKey = "API_KEY"
        static let hostUrl = "HOST_URL"
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist file not found")
        }
        return dict
    }()
    
    static var hostUrl: URL {
        guard let hostURLString = Config.infoDictionary[Keys.hostUrl] as? String else {
            fatalError("Host URL not set in plist")
        }
        
        guard let url = URL(string: hostURLString) else {
            fatalError("Host URL is in incorrect format")
        }
        return url
    }
}
