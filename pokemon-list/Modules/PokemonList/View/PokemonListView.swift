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
            tableView.refreshControl = getCommonRefreshControl()
            tableView.refreshControl?.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        }
    }

    @IBOutlet private weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }

    private var viewModel = PokemonListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupViewModel()
    }

    @objc private func refreshData(_ sender: Any) {
        tableView.refreshControl?.beginRefreshing()
        viewModel.currentPage = 1
        viewModel.getPokemons { [weak self] in
            self?.tableView.refreshControl?.endRefreshing()
        }
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
        viewModel.showErrorMessage = { [weak self] errorMessage in
            self?.showErrorMessage(error: errorMessage)
        }
        viewModel.getPokemons(completion: nil)
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

extension PokemonListView: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.keyword = ""
        searchBar.text = ""
        viewModel.currentPage = 1
        viewModel.getPokemons {
            searchBar.endEditing(true)
            searchBar.showsCancelButton = false
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.keyword = searchBar.text ?? ""
        if viewModel.keyword.isNotEmpty {
            viewModel.currentPage = 1
            viewModel.getPokemons {
                searchBar.endEditing(true)
                searchBar.showsCancelButton = false
            }
        }
    }
}
