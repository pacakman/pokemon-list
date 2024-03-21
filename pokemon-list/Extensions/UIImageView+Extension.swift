//
//  UIImageView+Extension.swift
//  pokemon-list
//
//  Created by Idris on 21/03/24.
//

import UIKit
import Kingfisher
extension UIImageView {
    func setImageFromURL(url: String, placeholder: String = "icon_placeholder_image") {
        kf.setImage(with: URL(string: url), placeholder: UIImage(named: placeholder))
    }
}
