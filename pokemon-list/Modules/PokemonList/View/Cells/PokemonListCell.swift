//
//  PokemonListCell.swift
//  pokemon-list
//
//  Created by Idris on 19/03/24.
//

import UIKit
import Kingfisher

class PokemonListCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet private weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 16
            containerView.layer.applyCustomShadow()
        }
    }

    @IBOutlet private weak var pokemonImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setupView(pokemon: PokemonAttribute) {
        pokemonImageView.setImageFromURL(url: pokemon.images.large)
    }
}
