//
//  UIView+Extension.swift
//  pokemon-list
//
//  Created by Idris on 19/03/24.
//

import UIKit
import SkeletonView

extension UIView {
    func showSkeletonAnimatedGradient(color: UIColor = .gray.withAlphaComponent(0.5),
                                        transition: SkeletonTransitionStyle = .crossDissolve(0.25)) {
        self.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: color), animation: nil, transition: transition)

    }

    func stopAndHideSkeleton(reloadDataAfter: Bool = false,
                               transition: SkeletonTransitionStyle = .crossDissolve(0.25)) {
        self.hideSkeleton(reloadDataAfter: reloadDataAfter, transition: .crossDissolve(0.25))

    }
}
