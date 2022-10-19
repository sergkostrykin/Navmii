//
//  UIViewExtension.swift
//  Navmii
//
//  Created by Sergiy Kostrykin on 19/10/2022.
//

import UIKit

extension UIView {
    
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    func embed(in containerView: UIView?, leading: CGFloat = 0, trailing: CGFloat = 0, top: CGFloat = 0, bottom: CGFloat = 0) {
        guard let containerView = containerView else { return }
        containerView.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: leading),
            self.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: trailing),
            self.topAnchor.constraint(equalTo: containerView.topAnchor, constant: top),
            self.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: bottom)
        ])
    }
    
    func removeSubviews() {
        self.subviews.forEach({ $0.removeFromSuperview()})
    }

}
