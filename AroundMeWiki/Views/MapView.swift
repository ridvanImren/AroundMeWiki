//
//  MapView.swift
//  AroundMeWiki
//
//  Created by Rıdvan İmren on 17.01.2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @StateObject private var viewModel: MapViewModel
    @EnvironmentObject var language: Language
    var body: some View {
        
        NavigationView {
            ZStack{
                Map(coordinateRegion: $viewModel.mapRegion, showsUserLocation: true, annotationItems: viewModel.pages.data) { page in
                    
                    MapAnnotation(coordinate: CLLocationCoordinate2D(
                        latitude: CLLocationDegrees(page.coordinates!.first!.lat),
                        longitude: CLLocationDegrees(page.coordinates!.first!.lon)) ) {
                            VStack {
                                Group {
                                    if let thumbnail = page.thumbnail?.source {
                                        if let thumbnailURL = URL(string: thumbnail) {
                                            AsyncImage(url: thumbnailURL) { image in
                                                image
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width:32, height: 32)
                                                    .clipShape(Capsule())
                                                    .overlay(
                                                        Capsule()
                                                            .strokeBorder(.white, lineWidth: 1))

                                            } placeholder: {
                                                Image("Wiki")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width:32, height: 32)
                                                    .clipShape(Capsule())
                                            }
                                            
                                        }
                                    } else {
                                        Image("Wiki")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width:32, height: 32)
                                            .clipShape(Capsule())
                                        
                                    }
                                }
                            }
                            .onTapGesture{
                                viewModel.selectedPage = page
                                
                            }
                            .contextMenu {
                                Text(page.title)
                                    .font(.headline)
                                
                            }
                        }
                }
                .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Spacer()
                        VStack(alignment:.trailing) {
                            Button {

                                Task {
                                    await viewModel.fetchAroundPlaces()
                                }
                            } label: {
                                Text("Show Surroundings")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(width:200, height: 40)
                                    .background(.blue)
                                    .cornerRadius(50)
                                    .opacity(0.7)
                                
                                
                            }
                            
                            //Location button here
                            Button{
                                viewModel.checkifLocationServicesIsEnabled()
                            } label: {
                                Image(systemName: "location.fill")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(width:40, height: 40)
                                    .background(.blue)
                                    .cornerRadius(50)
                                    .opacity(0.7)

                            }
                            Spacer()
                        }
                        .padding([.horizontal])
                    }
                    Spacer()
                }
                
                .sheet(item: $viewModel.selectedPage) { page in
                    DetailView(page: page)
                }
            }
            .onAppear{
                Task {
                    await viewModel.fetchAroundPlaces()
                }
                if !viewModel.gotLocation {
                    viewModel.checkifLocationServicesIsEnabled()
                    viewModel.gotLocation = true
                }
                self.viewModel.setup(self.language)
                
            }


        }

        .preferredColorScheme(.dark)
        
    }

    
    init(pages: Pages) {
        _viewModel = StateObject(wrappedValue: MapViewModel(pages: pages))
    }
    
}
