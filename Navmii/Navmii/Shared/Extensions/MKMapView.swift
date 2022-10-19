//
//  MKMapView.swift
//  Navmii
//
//  Created by Sergiy Kostrykin on 19/10/2022.
//

import Foundation
import MapKit

extension MKMapView {
    
    func setCameraPosition(coordinate: CLLocationCoordinate2D, zoomLevel: Int, animated: Bool) {
        let span = MKCoordinateSpan(latitudeDelta: 0, longitudeDelta: 360 / pow(2, Double(zoomLevel)) * Double(self.frame.size.width) / 256)
        setRegion(MKCoordinateRegion(center: coordinate, span: span), animated: animated)
    }

}
