//
//  StringExtension.swift
//  Navmii
//
//  Created by Sergiy Kostrykin on 19/10/2022.
//


import Foundation

extension String {

    var url: URL? {
        URL(string: self)
    }
    
    var createdAtDateString: String? {
        Date.standardDateFormatter.date(from: self)?.createdAtDateString
    }
    
    var filename: String {
        URL(fileURLWithPath: self).deletingPathExtension().lastPathComponent
    }

    var fileExtension: String {
        URL(fileURLWithPath: self).pathExtension
    }

}
