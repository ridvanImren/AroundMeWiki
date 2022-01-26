//
//  SettingsView.swift
//  AroundMeWiki
//
//  Created by Rıdvan İmren on 20.01.2022.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var language: Language
    @State private var langString = "English"
    var body: some View {
        VStack(alignment: .leading) {
            Form {
                HStack {
                    Text("Wiki Language")
                    
                    Menu() {
                        Button {
                            language.wikiLanguage = "en"
                            langString = "English"
                        } label: {
                            Text("English")
                            
                        }
                        
                        Button {
                            language.wikiLanguage = "tr"
                            langString = "Turkish"
                            
                            
                        } label: {
                            Text("Turkish")
                            
                        }
                    } label: {
                        Spacer()
                        Text(langString)
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
