//  
//  PokemonDetailView.swift
//  pokemon-list
//
//  Created by Idris on 19/03/24.
//

import UIKit

class PokemonDetailView: UIViewController {

    var viewModel = PokemonDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }
    
    func setupViewModel() {

        viewModel.showAlertClosure = {

        }
        
        viewModel.updateLoadingStatus = {

        }

        viewModel.internetConnectionStatus = {

        }

        viewModel.serverErrorStatus = {
        }

        viewModel.didGetData = {
            
        }

    }
    
}


