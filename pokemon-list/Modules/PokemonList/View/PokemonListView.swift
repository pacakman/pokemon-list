//
//  PokemonListView.swift
//  pokemon-list
//
//  Created by Idris on 19/03/24.
//

import UIKit
import SkeletonView
import UIScrollView_InfiniteScroll

class PokemonListView: BaseViewController {

    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.registerNIB(with: PokemonListCell.self)
            tableView.registerNIB(with: PokemonListEmptyCell.self)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.estimatedRowHeight = 250
            tableView.infiniteScrollTriggerOffset = 100
            tableView.setShouldShowInfiniteScrollHandler { [weak self] _ in
                return self?.viewModel.canLoadMorePokemons ?? false
            }
            tableView.addInfiniteScroll { [weak self] scrollView in
                self?.viewModel.getPokemons {
                    scrollView.finishInfiniteScroll()
                }
            }
            tableView.showsVerticalScrollIndicator = false
        }
    }


    var viewModel = PokemonListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    private func setupView() {
        title = "Pokemon"
    }

    func setupViewModel() {
        viewModel.updateLoadingStatus = { [weak self] isLoading in
            let currentPage = self?.viewModel.currentPage ?? 1
            if isLoading && currentPage == 1 {
                self?.tableView.showAnimatedGradientSkeleton()
            }
            else {
                self?.tableView.stopSkeletonAnimation()
                self?.tableView.hideSkeleton()
            }
        }
        viewModel.didGetPokemons = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.getPokemons(completion: nil)
        viewModel.updateConnectionStatus = { [weak self] isConnected in
            if isConnected {
                self?.dismiss(animated: true)
            }
            else {
                self?.showNoConnection()
            }
        }
    }

}



extension PokemonListView: SkeletonTableViewDataSource, UITableViewDelegate {
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return String(describing: PokemonListCell.self)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // dequeue pokemon cell
        if let contentCell = tableView.dequeueCell(with: PokemonListCell.self), viewModel.pokemons.isNotEmpty {
            let pokemon = viewModel.selectPokemonAtIndex(index: indexPath.row)
            contentCell.selectionStyle = .none
            contentCell.setupView(pokemon: pokemon)
            return contentCell
        }

        // dequeue empty pokemon cell
        if let contentCell = tableView.dequeueCell(with: PokemonListEmptyCell.self), viewModel.pokemons.isEmpty {
            contentCell.selectionStyle = .none
            return contentCell
        }

        let defaultCell = UITableViewCell()
        defaultCell.selectionStyle = .none
        return defaultCell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.pokemons.isEmpty {
            return 1
        }
        return viewModel.pokemons.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if viewModel.pokemons.isEmpty && !tableView.isSkeletonActive {
            return UITableView.automaticDimension
        }
        return 450
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel.pokemons.isNotEmpty {
            let pokemon = viewModel.selectPokemonAtIndex(index: indexPath.row)
            let controller = PokemonDetailView(pokemonAttribute: pokemon)
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}
