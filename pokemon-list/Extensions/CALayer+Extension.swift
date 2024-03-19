//
//  CALayer+Extension.swift
//  pokemon-list
//
//  Created by Idris on 19/03/24.
//

import UIKit

extension CALayer {
    func applyCustomShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        xAxis: CGFloat = 0,
        yAxis: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0) {
            shadowColor = color.cgColor
            shadowOpacity = alpha
            shadowOffset = CGSize(width: xAxis, height: yAxis)
            shadowRadius = blur / 2.0
            if spread == 0 {
                shadowPath = nil
            } else {
                let diagonalX = -spread
                let rect = bounds.insetBy(dx: diagonalX, dy: diagonalX)
                shadowPath = UIBezierPath(rect: rect).cgPath
            }
        }
}
