//
//  NSErrorExtension.swift
//  Navmii
//
//  Created by Sergiy Kostrykin on 19/10/2022.
//

import Foundation

extension NSError {
    class func standard(message: String?, code: Int = 0) -> NSError {
        return NSError(domain: "self", code: code, userInfo: [NSLocalizedDescriptionKey: message ?? ""])
    }
}
