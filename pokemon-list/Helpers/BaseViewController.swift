//
//  BaseViewController.swift
//  pokemon-list
//
//  Created by Idris on 21/03/24.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func showNoConnection() {
        let vc = NoConnectionView()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .coverVertical
        present(vc, animated: true)
    }
}
