//
//  PokemonProvider.swift
//  pokemon-list
//
//  Created by Idris on 19/03/24.
//

import Foundation
import Moya
enum PokemonProvider {
    case getPokemon(page: Int = 1, keyword: String = "")
}

extension PokemonProvider: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.pokemontcg.io/v2/")!
    }

    var path: String {
        switch self {
        case .getPokemon:
            return "cards"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        var data: [String:Any] = [:]
        switch self {
        case .getPokemon(let page, let keyword):
            data["page"] = page
            data["pageSize"] = 8
            if keyword.isNotEmpty {
                data["q"] = "name:\(keyword)"
            }
            return .requestParameters(parameters: data, encoding: URLEncoding.default)
        }
    }

    var headers: [String : String]? {
        return [
            "X-Api-Key":"48b11e4c-8eb2-485e-ba9a-032cbcbcc379",
            "If-None-Match":"*"
        ]
    }
}
