//
//  BaseViewController.swift
//  pokemon-list
//
//  Created by Idris on 21/03/24.
//

import UIKit
import NotificationBannerSwift

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

    func dismissCurrentView() {
        self.dismiss(animated: true)
    }

    func showErrorMessage(error: String) {
        let toast = FloatingNotificationBanner(
            title: error,
            titleFont: .systemFont(ofSize: 16, weight: .semibold),
            titleColor: .white,
            titleTextAlign: .center,
            style: .danger
        )

        toast.show(edgeInsets:  UIEdgeInsets(top: 12, left: 16, bottom: 0, right: 16), cornerRadius: 6)
    }
}
