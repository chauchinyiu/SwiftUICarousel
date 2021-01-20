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
    var uiState: UIStateModel
    
    var body: some View
    {
        let spacing:            CGFloat = 16
        let widthOfHiddenCards: CGFloat = 32    // UIScreen.main.bounds.width - 10
        let cardHeight:         CGFloat = 279

        let items = [
                        Card(id: 0, name: "Hey", imageURL: URL(string:"https://i.ibb.co/JRys8bV/karten-skizze-master.png")),
                        Card(id: 1, name: "Ho", imageURL: URL(string:"https://i.ibb.co/JRys8bV/karten-skizze-master.png")),
                        Card(id: 2, name: "Lets", imageURL: URL(string:"https://i.ibb.co/JRys8bV/karten-skizze-master.png")),
                        Card(id: 3, name: "Go", imageURL: URL(string:"https://i.ibb.co/JRys8bV/karten-skizze-master.png"))
                    ]
        
        return  Canvas
                {
                    //
                    // TODO: find a way to avoid passing same arguments to Carousel and Item
                    //
                    Carousel( numberOfItems: CGFloat( items.count ), spacing: spacing, widthOfHiddenCards: widthOfHiddenCards )
                    {
                        ForEach( items, id: \.self.id ) { item in
   
                            Item( _id:                  Int(item.id),
                                  spacing:              spacing,
                                  widthOfHiddenCards:   widthOfHiddenCards,
                                  cardHeight:           cardHeight )
                            {
                                if let url = item.imageURL {
                                    AsyncImage(
                                        url: url,
                                        placeholder: { Text("Loading ...") },
                                        image: { Image(uiImage: $0).resizable() }
                                    ).aspectRatio(contentMode: .fit)
                                }else{
                                    Text("\(item.name)")
                                }
                            }
                            .foregroundColor( Color.red )
                            .background( Color.black )
                            .cornerRadius( 8 )
                            .shadow( color: Color( "shadow1" ), radius: 4, x: 0, y: 4 )
                            .transition( AnyTransition.slide )
                            .animation( .spring() )
                        }
                    }
                    .environmentObject( self.uiState )
                }
    }
}

struct Card: Decodable, Hashable, Identifiable {
    var id: Int
    var name: String = ""
    var imageURL: URL?
}
//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftUIView()
//    }
//}
