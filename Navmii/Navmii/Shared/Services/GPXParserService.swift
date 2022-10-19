//
//  GPXParserService.swift
//  Navmii
//
//  Created by Sergiy Kostrykin on 19/10/2022.
//

import Foundation
import CoreLocation

class GPXParserService: NSObject {
        
    private var coordinates = [CLLocationCoordinate2D]()
    private var completion: (([CLLocationCoordinate2D]?, Error?)->())?
    
    func parse(_ file: String, completion: (([CLLocationCoordinate2D]?, Error?)->())?) {
        self.completion = completion
        guard let url = resolvePath(file: file) else {
            completion?(nil, NSError.standard(message: "The file couldn't be opened because there is no such file.", code: -1))
            return
        }
        
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                let parser = XMLParser(data: data)
                parser.delegate = self
                parser.parse()
            } catch {
                DispatchQueue.main.async {
                    completion?(nil, error)
                }
            }
        }
    }
    
    private func resolvePath(file: String) -> URL? {
        let path = Bundle.main.path(forResource: file.filename, ofType: file.fileExtension) ?? file
        if FileManager.default.fileExists(atPath: path) {
            return URL(fileURLWithPath: path)
        } else {
            return URL(string: path)
        }
    }
}

extension GPXParserService: XMLParserDelegate {

    private struct Key {
        static let lat = "lat"
        static let lon = "lon"
        static let trackPoint = "trkpt"
        static let wayPoint = "wpt"
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        guard
            (elementName == Key.trackPoint || elementName == Key.wayPoint),
            let latitude = attributeDict[Key.lat],
            let latitude = CLLocationDegrees(latitude),
            let longitude = attributeDict[Key.lon],
            let longitude = CLLocationDegrees(longitude)
        else {
            return
        }
        coordinates.append(CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.completion?(self.coordinates, nil)
        }
    }

}
