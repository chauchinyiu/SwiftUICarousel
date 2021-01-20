//
//  Carousel.swift
//  SwiftUICarousel
//
//  Created by Chau Chin Yiu on 18.01.21.
//

import SwiftUI


public class UIStateModel: ObservableObject {
    @Published var activeCard: Int = 0
    @Published var screenDrag: Float = 0.0
    public init() {
        
    }
}


public struct Carousel<Items : View> : View {
    let items: Items
    let numberOfItems: CGFloat //= 8
    let spacing: CGFloat //= 16
    let widthOfHiddenCards: CGFloat //= 32
    let totalSpacing: CGFloat
    let cardWidth: CGFloat
    
    @GestureState var isDetectingLongPress = false
    
    @EnvironmentObject var uiState: UIStateModel
    
    public init(
        numberOfItems: CGFloat,
        spacing: CGFloat,
        widthOfHiddenCards: CGFloat,
        @ViewBuilder _ items: () -> Items) {
        
        self.items = items()
        self.numberOfItems = numberOfItems
        self.spacing = spacing
        self.widthOfHiddenCards = widthOfHiddenCards
        self.totalSpacing = (numberOfItems - 1) * spacing
        self.cardWidth = UIScreen.main.bounds.width - (widthOfHiddenCards*2) - (spacing*2) //279
        
    }
    
    public var body: some View {
        let totalCanvasWidth: CGFloat = (cardWidth * numberOfItems) + totalSpacing
        let xOffsetToShift = (totalCanvasWidth - UIScreen.main.bounds.width) / 2
        let leftPadding = widthOfHiddenCards + spacing
        let totalMovement = cardWidth + spacing
        
        let activeOffset = xOffsetToShift + (leftPadding) - (totalMovement * CGFloat(uiState.activeCard))
        let nextOffset = xOffsetToShift + (leftPadding) - (totalMovement * CGFloat(uiState.activeCard) + 1)
        
        var calcOffset = Float(activeOffset)
        
        if (calcOffset != Float(nextOffset)) {
            calcOffset = Float(activeOffset) + uiState.screenDrag
        }
        
        return HStack(alignment: .center, spacing: spacing) {
            items
        }
        .offset(x: CGFloat(calcOffset), y: 0)
        .gesture(DragGesture().updating($isDetectingLongPress) { currentState, gestureState, transaction in
            self.uiState.screenDrag = Float(currentState.translation.width)
            
        }.onEnded { value in
            self.uiState.screenDrag = 0
            
            if (value.translation.width < -50) &&  self.uiState.activeCard < Int(numberOfItems) - 1 {
                self.uiState.activeCard = self.uiState.activeCard + 1
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
            }
            
            if (value.translation.width > 50) && self.uiState.activeCard > 0 {
                self.uiState.activeCard = self.uiState.activeCard - 1
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
            }
        }
        )
    }
}

struct Carousel_Previews: PreviewProvider {
    static var previews: some View {
            Carousel(numberOfItems: 10, spacing: 20, widthOfHiddenCards: 200) {
        }
    }
}
