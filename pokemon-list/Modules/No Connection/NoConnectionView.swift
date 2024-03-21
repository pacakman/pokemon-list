//
//  NoConnectionView.swift
//  pokemon-list
//
//  Created by Idris on 21/03/24.
//

import UIKit

class NoConnectionView: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var containerView: UIView!

    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
            titleLabel.textColor = .black
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        containerView.roundCorners(corners: [.topLeft, .topRight], radius: 16)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
