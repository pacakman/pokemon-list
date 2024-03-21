//
//  PokemonListEmptyCell.swift
//  pokemon-list
//
//  Created by Idris on 21/03/24.
//

import UIKit

class PokemonListEmptyCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
            titleLabel.textColor = .black
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
