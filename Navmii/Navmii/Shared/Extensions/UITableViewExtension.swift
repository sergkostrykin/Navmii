//
//  UITableViewExtension.swift
//  Navmii
//
//  Created by Sergiy Kostrykin on 19/10/2022.
//

import UIKit

extension UITableView {
    func register(cells: [String]) {
        cells.forEach({ self.register(UINib.init(nibName: $0, bundle: nil), forCellReuseIdentifier: $0) })
    }
}
