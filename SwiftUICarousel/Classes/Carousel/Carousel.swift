//
//  Carousel.swift
//  SwiftUICarousel
//
//  Created by Chau Chin Yiu on 18.01.21.
//

import SwiftUI


public class UIStateModel: ObservableObject {
    @Published public var activeCard: Int = 0
    @Published var screenDrag: Float = 0.0
    public init() {
        
    }
}

public struct Carousel<Data, Content>: View
where Data : RandomAccessCollection, Content : View, Data.Element : Identifiable
{
    private let data: [Data.Element]
    private let content: (Data.Element) -> Content
    
    
    let numberOfItems: Int
    let spacing: CGFloat
    let displayWidthOfSideCards: CGFloat
    let totalSpacing: CGFloat
    let cardWidth: CGFloat
    
    @GestureState var isDetectingLongPress = true
    
    @EnvironmentObject var uiState: UIStateModel
    
    public init(
        spacing: CGFloat,
        displayWidthOfSideCards: CGFloat,
        data: Data,
        @ViewBuilder content: @escaping (Data.Element) ->  Content) {
        
        self.data = data.map { $0 }
        self.content = content
        self.numberOfItems = self.data.count
        self.spacing = spacing
        self.displayWidthOfSideCards = displayWidthOfSideCards
        self.totalSpacing = CGFloat((numberOfItems - 1)) * spacing
        self.cardWidth = UIScreen.main.bounds.width - (displayWidthOfSideCards*2) - (spacing*2) //279
        
    }
    
    private func calculateOffset() -> Float{
        let totalCanvasWidth: CGFloat = (cardWidth * CGFloat(numberOfItems)) + totalSpacing
        let xOffsetToShift = (totalCanvasWidth - UIScreen.main.bounds.width) / 2
        let leftPadding = displayWidthOfSideCards + spacing
        let totalMovement = cardWidth + spacing
        let xmove = xOffsetToShift + (leftPadding)
        let activeCardTotalMove =  totalMovement * CGFloat(uiState.activeCard)
        let activeOffset =  xmove - activeCardTotalMove
        let nextOffset = xmove - (activeCardTotalMove + 1)
        
        var calcOffset = Float(activeOffset)
        
        if (calcOffset != Float(nextOffset)) {
            calcOffset = Float(activeOffset) + uiState.screenDrag
        }
        return calcOffset
    }
    
    public var body: some View {
        
        return HStack(alignment: .center, spacing: spacing) {
            ForEach(  data, id: \.self.id ) { data in
                self.content(data)
            }
            .transition( AnyTransition.slide )
            .animation( .spring() )
        }
        .offset(x: CGFloat(self.calculateOffset()), y: 0)
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

 
