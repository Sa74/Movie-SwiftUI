//
//  Navigation+BackButtonDisplay.swift
//  Movie-SwiftUI
//
//  Created by Sasi Moorthy on 25.04.23.
//

import UIKit

extension UINavigationController {
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationBar.topItem?.backButtonDisplayMode = .minimal
    }

    static func layoutNavigationBarBackButton() {
        if let image = UIImage(systemName: "arrow.backward") {
            UINavigationBar.appearance().backIndicatorImage = image
            UINavigationBar.appearance().backIndicatorTransitionMaskImage = image
        }
    }
}
