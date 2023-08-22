//
//  GeoJSON.swift
//  isSafe
//
//  Created by Nikita on 22/8/23.
//

import Foundation

struct GeoJSON: Decodable {
    
    private enum RootCodingKeys: String, CodingKey {
        case features
    }
    
    private enum FeatureCodingKey: String, CodingKey {
        case properties
    }
    
    private(set) var quakes: [Quake] = []
    
    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        var featureContainer = try rootContainer.nestedUnkeyedContainer(forKey: .features)
        
        while !featureContainer.isAtEnd {
            let propertiesContainer = try featureContainer.nestedContainer(keyedBy: FeatureCodingKey.self)
            
            if let properties = try? propertiesContainer.decode(Quake.self, forKey: .properties) {
                quakes.append(properties)
            }
        }
    }
}
