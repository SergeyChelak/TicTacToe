//
//  TapLocationGesture.swift
//  TicTacToe
//
//  Created by Serhii Chelak on 02.09.2022.
//

import SwiftUI

/// Slightly modified version of  https://codeutility.org/swift-how-to-detect-a-tap-gesture-location-in-swiftui-stack-overflow/
struct TapLocationGesture: Gesture {
    private let coordinateSpace: CoordinateSpace
    
    typealias Value = SimultaneousGesture<TapGesture, DragGesture>.Value
    
    init(coordinateSpace: CoordinateSpace = .local) {
        self.coordinateSpace = coordinateSpace
    }
    
    var body: SimultaneousGesture<TapGesture, DragGesture> {
        SimultaneousGesture(
            TapGesture(count: 1),
            DragGesture(minimumDistance: 0, coordinateSpace: coordinateSpace)
        )
    }
    
    func onEnded(_ action: @escaping (CGPoint) -> Void) -> _EndedGesture<TapLocationGesture> {
        onEnded { (value: Value) -> Void in
            guard value.first != nil,
                  let location = value.second?.startLocation,
                  let endLocation = value.second?.location,
                  (location.x-1)...(location.x+1) ~= endLocation.x,
                  (location.y-1)...(location.y+1) ~= endLocation.y else {
                return
            }
            action(location)
        }
    }
}
