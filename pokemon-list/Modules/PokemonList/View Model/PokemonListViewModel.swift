//  
//  PokemonListViewModel.swift
//  pokemon-list
//
//  Created by Idris on 19/03/24.
//

import Foundation

class PokemonListViewModel {

    private let service: PokemonListServiceProtocol

    private var networkStatus = Reach().connectionStatus()

    var currentPage: Int = 1
    var canLoadMorePokemons: Bool = false

    var isDisconnected: Bool = false {
        didSet {
            alertMessage = "No network connection. Please connect to the internet"
            internetConnectionStatus?()
        }
    }

    var isLoading: Bool = false {
        didSet {
            updateLoadingStatus?()
        }
    }

    var alertMessage: String? {
        didSet {
            showAlertClosure?()
        }
    }


    var showAlertClosure: (() -> Void)?
    var updateLoadingStatus: (() -> Void)?
    var internetConnectionStatus: (() -> Void)?

    init(withPokemonList service: PokemonListServiceProtocol = PokemonListService() ) {
        self.service = service

        NotificationCenter.default.addObserver(self, selector: #selector(self.networkStatusChanged(_:)), name: NSNotification.Name(rawValue: ReachabilityStatusChangedNotification), object: nil)
        Reach().monitorReachabilityChanges()
    }

    @objc func networkStatusChanged(_ notification: Notification) {
        self.networkStatus = Reach().connectionStatus()
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: ReachabilityStatusChangedNotification), object: nil)
    }
}

extension PokemonListViewModel {

}
