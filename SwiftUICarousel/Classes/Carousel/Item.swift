//
//  Item.swift
//  SwiftUICarousel
//
//  Created by Chau Chin Yiu on 19.01.21.
//

import SwiftUI

public struct Item<Content: View>: View {
    @EnvironmentObject var uiState: UIStateModel
    let cardWidth: CGFloat
    let cardHeight: CGFloat

    var _id: Int
    var content: Content

    public init(
        _id: Int,
        spacing: CGFloat,
        widthOfHiddenCards: CGFloat,
        cardHeight: CGFloat,
        @ViewBuilder _ content: () -> Content
    ) {
        self.content = content()
        self.cardWidth = UIScreen.main.bounds.width - (widthOfHiddenCards*2) - (spacing*2) //279
        self.cardHeight = cardHeight
        self._id = _id
    }

    public var body: some View {
        content
            .frame(width: cardWidth, height: _id == uiState.activeCard ? cardHeight : cardHeight - 60, alignment: .center)
    }
}
