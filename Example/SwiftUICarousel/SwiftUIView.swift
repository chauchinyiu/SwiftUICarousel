//
//  SwiftUIView.swift
//  SwiftUICarousel_Example
//
//  Created by Chau Chin Yiu on 19.01.21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import SwiftUI
import SwiftUICarousel

struct SwiftUIView: View {
    @ObservedObject var uiState: UIStateModel
    
    var body: some View
    {
        let spacing:            CGFloat = 16
        let displayWidthOfSideCards: CGFloat = 32    // UIScreen.main.bounds.width - 10
        let cardHeight:         CGFloat = 200
        
        let items = [
            Card(id: 0, name: "john wick", number: "123184971238711", imageURL: URL(string:"https://i.ibb.co/JRys8bV/karten-skizze-master.png")),
            Card(id: 1, name: "Hotung helo", number: "123184971238711", imageURL: URL(string:"https://i.ibb.co/JRys8bV/karten-skizze-master.png")),
            Card(id: 2, name: "Van dele No", number: "123184971238711", imageURL: URL(string:"https://i.ibb.co/JRys8bV/karten-skizze-master.png")),
            Card(id: 3, name: "Lok Wok", number: "123184971238711", imageURL: URL(string:"https://i.ibb.co/JRys8bV/karten-skizze-master.png"))
        ]
        VStack {
            Canvas
            {
                Carousel( spacing: spacing, displayWidthOfSideCards: displayWidthOfSideCards, data: items) { item in
                    ItemView( _id:  Int(item.id),
                              spacing: spacing,
                              displayWidthOfSideCards: displayWidthOfSideCards,
                              cardHeight: cardHeight )
                    {
                        ZStack {
                            Image("karten_skizze_master")
                                .resizable()
                                .scaledToFit()
                                .edgesIgnoringSafeArea(.all)
                            
                            VStack (alignment:.leading, spacing: 20.0) {
                                Spacer()
                                Text("\(item.number)")
                                
                                Text("\(item.name)")
                                Spacer()
                            }.background(Color.green)
                            .frame( height: cardHeight, alignment: .leading)
                            
                        }
                    }.foregroundColor( Color.white )
                    
                    .cornerRadius( 25 )
                    .shadow( color: Color.blue, radius: 20, x: 0, y: 4 )
                    .transition( AnyTransition.slide )
                    .animation( .spring() )
                    
                }
                .environmentObject( self.uiState )
            }
            Spacer()
            Text("Page : \(self.uiState.activeCard)")
        }
    }
}

struct Card: Decodable, Hashable, Identifiable {
    var id: Int
    var name: String = ""
    var number: String = ""
    var imageURL: URL?
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView(uiState: UIStateModel())
    }
}
