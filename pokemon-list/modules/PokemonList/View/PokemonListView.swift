//  
//  PokemonListView.swift
//  pokemon-list
//
//  Created by Idris on 19/03/24.
//

import UIKit

class PokemonListView: UIViewController {


    var viewModel = PokemonListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }
    
    func setupViewModel() {

        viewModel.showAlertClosure = {

        }

        viewModel.internetConnectionStatus = {

        }
    }
    
}


