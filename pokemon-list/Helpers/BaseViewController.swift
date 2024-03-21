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

    func getCommonRefreshControl() -> UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .darkGray
        refreshControl.backgroundColor = .clear
        return refreshControl
    }
}
