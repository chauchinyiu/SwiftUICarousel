//
//  ItemView.swift
//  SwiftUICarousel
//
//  Created by Chau Chin Yiu on 19.01.21.
//

import SwiftUI

public struct ItemView<Content: View>: View {
    @EnvironmentObject var uiState: UIStateModel
    let cardWidth: CGFloat
    let cardHeight: CGFloat

    var _id: Int
    var content: Content

    public init(
        _id: Int,
        spacing: CGFloat,
        displayWidthOfSideCards: CGFloat,
        cardHeight: CGFloat,
        @ViewBuilder _ content: () -> Content
    ) {
        self.content = content()
        self.cardWidth = UIScreen.main.bounds.width - (displayWidthOfSideCards*2) - (spacing*2) //279
        self.cardHeight = cardHeight
        self._id = _id
    }

    public var body: some View {
        content
            .frame(width: cardWidth, alignment: .center)
    }
}
