//
//  ViewModifier.swift
//  IOS18VerticalSlider
//
//  Created by Vishnu on 2025-03-25.
//

import SwiftUI

struct Slide: ViewModifier
{
    enum DragState
    {
        case inactive
        case pressing
        case dragging(translation: CGSize)
        
        var translation: CGSize
        {
            switch self
            {
            case .inactive, .pressing:
                return .zero
            case .dragging(let translation):
                return translation
            }
        }
        
        var isActive: Bool
        {
            switch self
            {
            case .inactive:
                return false
            case .pressing, .dragging:
                return true
            }
        }
        
        var isDragging: Bool
        {
            switch self
            {
            case .inactive, .pressing:
                return false
            case .dragging:
                return true
            }
        }
    }
    
    @GestureState private var dragState = DragState.inactive
    @Binding var slider: Slider
    
    func body(content: Content) -> some View
    {
        let minimumLongPressDuration = 0.2
        let longPressDrag = LongPressGesture(minimumDuration: minimumLongPressDuration)
            .sequenced(before: DragGesture())
            .updating($dragState)
        {
            value, state, transaction in
            switch value
            {
                // Long press begins.
            case .first(true):
                state = .pressing
                // Long press confirmed, dragging may begin.
            case .second(true, let drag):
                state = .dragging(translation: drag?.translation ?? .zero)
                // Dragging ended or the long press cancelled.
            default:
                state = .inactive
            }
        }
        .onEnded
        {
            value in
            guard case .second(true, let drag?) = value else { return }
            
            slider.wrappedValue =  slider.wrappedValue + -drag.translation.height
        }
        
        return content
            .frame(height: slider.wrappedValue - dragState.translation.height)
            .gesture(longPressDrag)
            .animation(.linear(duration: -0.1), value: 6)
            .frame(height: slider.maxValue, alignment: .bottom)
            .background
        {
            GlossyBar(width: 60)
                .gesture(longPressDrag)
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

extension View
{
    func adjustVolumeBar(slider: Binding<Slider>) -> some View
    {
        self.modifier(Slide(slider: slider))
    }
}
