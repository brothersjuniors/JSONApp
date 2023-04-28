//
//  JSONmodel.swift
//  JSon App
//
//  Created by 近江伸一 on 2023/04/12.
//

import Foundation
struct Products: Decodable {
    let maker: String
    let name: String
    let capa: Int
    let jan: Int
    let janID: String
    enum CodingKeys: CodingKey {
        case maker
        case name
        case capa
        case jan
        case janID
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.maker = try container.decode(String.self, forKey: .maker)
        self.name = try container.decode(String.self, forKey: .name)
        self.capa = try container.decode(Int.self, forKey: .capa)
        self.jan = try container.decode(Int.self, forKey: .jan)
        self.janID = try container.decode(String.self, forKey: .janID)
    }
}
