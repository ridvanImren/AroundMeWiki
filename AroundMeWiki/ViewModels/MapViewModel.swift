//
//  MapViewModel.swift
//  AroundMeWiki
//
//  Created by Rıdvan İmren on 20.01.2022.
//

import MapKit
enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 39.967039, longitude: 32.64505)
}

@MainActor class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var mapRegion = MKCoordinateRegion(center: MapDetails.startingLocation , latitudinalMeters: 5000, longitudinalMeters: 5000)
    @Published var pages: Pages
    @Published var selectedPage: Page?
    @Published var gotLocation = false
    @Published var update = false
    @Published var langChanged = false
    var language = Language() {
        didSet {
            langChanged = true
            
        }
    }

        
    var locationManager: CLLocationManager?
    
    func checkifLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        } else {
            // Location is not active, show an alert
        }
    }
    
    func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // Location is restricted.
            print("Your location is restricted.")
        case .denied:
            // Add alert
            print("Location denied. Go to settings to change.")
        case .authorizedAlways, .authorizedWhenInUse:
            mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 39.96703, longitude: locationManager.location?.coordinate.longitude ?? 32.64505), latitudinalMeters: 5000, longitudinalMeters: 5000)

        @unknown default:
            break
        }
        
    }
    
    internal func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func fetchAroundPlaces() async {
        

        let urlString = "https://\(language.wikiLanguage).wikipedia.org/w/api.php?ggscoord=\(mapRegion.center.latitude)%7C\(mapRegion.center.longitude)&action=query&prop=coordinates%7Cpageimages&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"

        
        guard let url = URL(string: urlString) else {
            print("URL cannot be created from: \(urlString)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let results = try JSONDecoder().decode(Result.self, from: data)
            pages.data = results.query.pages.values.sorted()
        } catch {
            print("Fetch failed")
        }
        update = !update
    }
    
    init(pages: Pages) {
        self.pages = pages
    }
    func setup(_ language: Language) {
        self.language = language
    }
    
}
