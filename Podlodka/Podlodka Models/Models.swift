//
//  Models.swift
//  Podlodka
//
//  Created by Андрей Сергеевич on 16.03.2023.
//

import Foundation
import UIKit

enum Keys: String{
    case date
}

class Podlodka: Codable {
    
    var name: String
    var image: Int
    var score: Int
    var date: String
    
    init(name: String, image: Int, score: Int, date: String){
        self.name = name
        self.image = image
        self.score = score
        self.date = date
    }
    convenience init(score: Int, name: String = "default name", image: Int = 0, date: String){
            self.init(name: name, image: image, score: score, date: date)
        }
    
    enum CodingKeys: String, CodingKey {
        case name, image, score, date
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.image = try container.decode(Int.self, forKey: .image)
        self.score = try container.decode(Int.self, forKey: .score)
        self.date = try container.decode(String.self, forKey: .date)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.name, forKey: .name)
        try container.encode(self.image, forKey: .image)
        try container.encode(self.score, forKey: .score)
        try container.encode(self.date, forKey: .date)
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
