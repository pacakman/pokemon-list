//  
//  PokemonListModel.swift
//  pokemon-list
//
//  Created by Idris on 19/03/24.
//

import Foundation

struct PokemonListModel: Decodable {
    let data: [PokemonAttribute]
    let page, pageSize, count, totalCount: Int
}

struct PokemonAttribute: Decodable {
    let id, name, supertype: String
    let subtypes: [String]
    let level: String?
    let hp: String
    let images: SetImages
    let flavorText: String?
    let evolvesFrom: String?
    let types: [String]

    func getJoinedType() -> String {
        return types.joined(separator: ", ")
    }
}

struct SetImages: Decodable {
    let small, large: String
}
