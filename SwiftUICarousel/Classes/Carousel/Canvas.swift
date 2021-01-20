//
//  Canvas.swift
//  SwiftUICarousel
//
//  Created by Chau Chin Yiu on 19.01.21.
//

import SwiftUI

public struct Canvas<Content : View> : View {
    let content: Content
    @EnvironmentObject var UIState: UIStateModel
    
    public init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        content
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}
