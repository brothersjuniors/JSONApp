//
//  JSONmodel.swift
//  JSon App
//
//  Created by 近江伸一 on 2023/04/12.
//

import Foundation
struct Products: Decodable {
    let maker: String
    let name: Int
    let capa: String
    let jan: String
    enum CodingKeys: CodingKey {
        case maker
        case name
        case capa
        case jan
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.maker = try container.decode(String.self, forKey: .maker)
        self.name = try container.decode(Int.self, forKey: .name)
        self.capa = try container.decode(String.self, forKey: .capa)
        self.jan = try container.decode(String.self, forKey: .jan)
    }
}
