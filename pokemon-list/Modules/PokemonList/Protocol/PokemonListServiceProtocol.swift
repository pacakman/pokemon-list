//  
//  PokemonListServiceProtocol.swift
//  pokemon-list
//
//  Created by Idris on 19/03/24.
//

import Foundation

protocol PokemonListServiceProtocol {
    func getPokemons(page: Int, keyword: String, onSuccess: ((PokemonListModel) -> Void)?, onFailure: ((Error) -> Void)?)
}
