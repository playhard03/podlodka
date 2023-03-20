//
//  Models.swift
//  Podlodka
//
//  Created by Андрей Сергеевич on 16.03.2023.
//

import Foundation
import UIKit


class Podlodka: Codable {
    
    var name: String
    var image: Int
    var score: Int
    
    init(name: String, image: Int, score: Int){
        self.name = name
        self.image = image
        self.score = score
    }
    convenience init(score: Int, name: String = "default name", image: Int = 0){
            self.init(name: name, image: image, score: score)
        }
    
    enum CodingKeys: String, CodingKey {
        case name, image, score
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.image = try container.decode(Int.self, forKey: .image)
        self.score = try container.decode(Int.self, forKey: .score)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.name, forKey: .name)
        try container.encode(self.image, forKey: .image)
        try container.encode(self.score, forKey: .score)
    }
    
}

extension UserDefaults {
    func setValue<T: Encodable>(encodable: T, forKey key: String) {
        if let data =  try? JSONEncoder().encode(encodable) {
            setValue(data, forKey: key)
        }
    }
    
    func value<T: Decodable>(_ type: T.Type, forKey key: String ) -> T? {
        if let data = object(forKey: key) as? Data,
           let value = try? JSONDecoder().decode(type, from: data){
            return value
        }
        return nil
    }
}
