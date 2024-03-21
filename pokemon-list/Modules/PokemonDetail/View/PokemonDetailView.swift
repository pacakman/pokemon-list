//  
//  PokemonDetailView.swift
//  pokemon-list
//
//  Created by Idris on 19/03/24.
//

import UIKit

class PokemonDetailView: BaseViewController {

    // MARK: Outlets
    @IBOutlet private weak var pokemonImageView: UIImageView!

    @IBOutlet private weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.font = .italicSystemFont(ofSize: 16)
            descriptionLabel.textColor = .black
        }
    }

    @IBOutlet private weak var evolveFromTitleLabel: UILabel! {
        didSet {
            evolveFromTitleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
            evolveFromTitleLabel.textColor = .black
        }
    }

    @IBOutlet private weak var typeTitleLabel: UILabel! {
        didSet {
            typeTitleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
            typeTitleLabel.textColor = .black
        }
    }

    @IBOutlet private weak var typeLabel: UILabel! {
        didSet {
            typeLabel.font = .systemFont(ofSize: 14, weight: .regular)
            typeLabel.textColor = .black
        }
    }

    @IBOutlet private weak var evolveFromLabel: UILabel! {
        didSet {
            evolveFromLabel.font = .systemFont(ofSize: 14, weight: .regular)
            evolveFromLabel.textColor = .black
        }
    }

    @IBOutlet private weak var nameLabel: UILabel! {
        didSet {
            nameLabel.font = .systemFont(ofSize: 18, weight: .semibold)
            nameLabel.textColor = .black
        }
    }

    @IBOutlet private weak var hpTitleLabel: UILabel! {
        didSet {
            hpTitleLabel.font = .systemFont(ofSize: 14, weight: .regular)
            hpTitleLabel.textColor = .black
        }
    }

    @IBOutlet private weak var hpLabel: UILabel! {
        didSet {
            hpLabel.font = .systemFont(ofSize: 18, weight: .bold)
            hpLabel.textColor = .orange
        }
    }

    @IBOutlet private weak var hpContainerView: UIView! {
        didSet {
            hpContainerView.layer.cornerRadius = hpContainerView.frame.width / 2
        }
    }

    // MARK: - Properties
    private var pokemonAttribute: PokemonAttribute

    init(pokemonAttribute: PokemonAttribute) {
        self.pokemonAttribute = pokemonAttribute
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        title = "Pokemon Detail"
    }
    
    private func setupView() {
        pokemonImageView.setImageFromURL(url: pokemonAttribute.images.large)
        descriptionLabel.text = pokemonAttribute.flavorText ?? "-"
        nameLabel.text = pokemonAttribute.name
        evolveFromLabel.text = pokemonAttribute.evolvesFrom ?? "-"
        typeLabel.text = pokemonAttribute.getJoinedType()
        hpLabel.text = pokemonAttribute.hp
    }
}


