//  
//  PokemonListView.swift
//  pokemon-list
//
//  Created by Idris on 19/03/24.
//

import UIKit
import SkeletonView

class PokemonListView: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.registerNIB(with: PokemonListCell.self)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.estimatedRowHeight = 150
        }
    }


    var viewModel = PokemonListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupView()
    }

    private func setupView() {
        title = "Pokemon"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func setupViewModel() {

        viewModel.showAlertClosure = {

        }

        viewModel.internetConnectionStatus = {

        }
    }
    
}



extension PokemonListView: SkeletonTableViewDataSource, UITableViewDelegate {
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return String(describing: PokemonListCell.self)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let contentCell = tableView.dequeueCell(with: PokemonListCell.self) {
            contentCell.selectionStyle = .none

            return contentCell
        }

        let defaultCell = UITableViewCell()
        defaultCell.selectionStyle = .none
        return defaultCell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}
