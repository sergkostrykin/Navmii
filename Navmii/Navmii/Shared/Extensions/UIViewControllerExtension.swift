//
//  StringExtension.swift
//  Navmii
//
//  Created by Sergiy Kostrykin on 19/10/2022.
//

import UIKit

extension UIViewController {
    
    var navigationEmbedded: UINavigationController {
        let navigation = UINavigationController(rootViewController: self)
        navigation.isNavigationBarHidden = true
        return navigation
    }
    
    static func instantiate(storyboard: String) -> UIViewController {
        instantiate(identifier: String(describing: self), storyboard: storyboard)
    }
    
    static func instantiate(identifier: String, storyboard: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
}
