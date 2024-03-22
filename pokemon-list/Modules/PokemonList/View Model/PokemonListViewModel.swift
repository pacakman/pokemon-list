//  
//  PokemonListViewModel.swift
//  pokemon-list
//
//  Created by Idris on 19/03/24.
//

import Foundation

class PokemonListViewModel {

    private let service: PokemonListServiceProtocol

    var currentPage: Int = 1
    var canLoadMorePokemons: Bool = false
    var keyword: String = ""
    var pokemons: [PokemonAttribute] = []

    var updateLoadingStatus: ((Bool) -> Void)?
    var didGetPokemons: (() -> Void)?
    var showErrorMessage: ((String) -> Void)?

    init(withPokemonList service: PokemonListServiceProtocol = PokemonListService() ) {
        self.service = service
    }

    func getPokemons(completion: (() -> Void)?) {
        updateLoadingStatus?(true)
        service.getPokemons(page: currentPage, keyword: keyword) { [weak self] result in
            let totalData = self?.pokemons.count ?? 0
            if let currentPage = self?.currentPage, currentPage == 1 {
                self?.pokemons = result.data
            }
            else {
                self?.pokemons.append(contentsOf: result.data)
            }
            self?.canLoadMorePokemons = totalData < result.totalCount
            if let canLoadMorePokemons = self?.canLoadMorePokemons, canLoadMorePokemons{
                self?.currentPage += 1
            }
            self?.updateLoadingStatus?(false)
            self?.didGetPokemons?()
            completion?()
        } onFailure: { [weak self] error in
            self?.updateLoadingStatus?(false)
            self?.showErrorMessage?(error.customErroMessage)
            completion?()
        }

    }

    func selectPokemonAtIndex(index: Int) -> PokemonAttribute {
        return pokemons[index]
    }
}
