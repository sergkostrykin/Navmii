//
//  MockFactory.swift
//  NavmiiTests
//
//  Created by Sergiy Kostrykin on 19/10/2022.
//

import Foundation

class MockFactory {
    
    class var validGPXFile: String {
        Bundle.main.path(forResource: "Track 110-03-01 02-56", ofType: "gpx") ?? ""
    }

    class var invalidGPXFile: String {
        "invalid.file"
    }

    class var remoteGPXFile: String {
        "https://raw.githubusercontent.com/gps-touring/sample-gpx/master/BrittanyJura/Courgenay_Ballon-DAlsace.gpx"
    }

    class var invalidRemoteGPXFile: String {
        "https://link.gpx"
    }

}
