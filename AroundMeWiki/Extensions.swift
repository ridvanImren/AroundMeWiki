//
//  Location.swift
//  AroundMeWiki
//
//  Created by Rıdvan İmren on 17.01.2022.
//

import Foundation
import CoreLocation
import MapKit



extension MKCoordinateRegion {
    public var radius: Int {
        let loc1 = CLLocation(latitude: center.latitude - span.latitudeDelta * 0.5, longitude: center.longitude)
        let loc2 = CLLocation(latitude: center.latitude + span.latitudeDelta * 0.5, longitude: center.longitude)
        let loc3 = CLLocation(latitude: center.latitude, longitude: center.longitude - span.longitudeDelta * 0.5)
        let loc4 = CLLocation(latitude: center.latitude, longitude: center.longitude + span.longitudeDelta * 0.5)
    
        let metersInLatitude = loc1.distance(from: loc2)
        let metersInLongitude = loc3.distance(from: loc4)
        let radius = max(metersInLatitude, metersInLongitude) / 2.0 + 1000
        return Int(radius)
    }
    
    public var mapPin: String {
        if radius > 4000 {
            return "pin"
        } else {
            return "pin.square.fill"
        }
    }
    public enum pinStyle {
        case asd, assd
    }
}


class Language: ObservableObject, Identifiable {
    let id = UUID()
    @Published var wikiLanguage = "en"
}
