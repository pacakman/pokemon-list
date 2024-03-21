//  
//  PokemonListService.swift
//  pokemon-list
//
//  Created by Idris on 19/03/24.
//

import Foundation
import Moya

class PokemonListService: PokemonListServiceProtocol, APIMappingProtocol {
    private let provider: MoyaProvider<PokemonProvider>

    init(provider: MoyaProvider<PokemonProvider> = MoyaProvider<PokemonProvider>()) {
        self.provider = provider
    }

    func getPokemons(page: Int, keyword: String, onSuccess: ((PokemonListModel) -> Void)?, onFailure: ((Error) -> Void)?) {
        provider.request(.getPokemon(page: page, keyword: keyword)) { [weak self] result in
            self?.handleResult(result, typeResponse: PokemonListModel.self, onSuccess: onSuccess, onFailure: onFailure)
        }
    }
}
