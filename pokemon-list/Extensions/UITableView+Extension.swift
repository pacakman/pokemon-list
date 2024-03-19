//
//  UITableView+Extension.swift
//  pokemon-list
//
//  Created by Idris on 19/03/24.
//

import UIKit

extension UITableView {
    func registerNIB(with cellClass: AnyClass) {
        let className = String(describing: cellClass)
        let bundle = Bundle(for: cellClass)
        register(UINib(nibName: className, bundle: bundle), forCellReuseIdentifier: className)
    }

    func dequeueCell<T>(with cellClass: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: String(describing: cellClass)) as? T
    }
}
