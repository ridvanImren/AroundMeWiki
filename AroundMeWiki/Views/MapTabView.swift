//
//  MapTabView.swift
//  AroundMeWiki
//
//  Created by Rıdvan İmren on 20.01.2022.
//

import SwiftUI

struct MapTabView: View {
    
    @StateObject var pages = Pages()
    @StateObject private var language = Language()
    var body: some View {
        TabView{
            MapView(pages: pages).environmentObject(language)
                .tabItem {
                    Label("Map", systemImage: "map")
                        .font(.largeTitle)
                    
                }
            
            MapListView(pages: pages).environmentObject(language)
                .tabItem{
                    Label("List", systemImage: "list.bullet.circle")
                        .font(.title)
                    
                }
                .badge(pages.data.count)
            
            SettingsView().environmentObject(language)
            
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
              
        }
        .onAppear{
            let apparence = UITabBarAppearance()
            apparence.configureWithDefaultBackground()
            UITabBar.appearance().scrollEdgeAppearance = apparence
            UITabBar.appearance().barTintColor = .black
        }
        
        
        
        
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        MapTabView()
    }
}
