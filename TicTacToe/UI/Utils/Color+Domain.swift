//
//  Color+Domain.swift
//  TicTacToe
//
//  Created by Serhii Chelak on 03.09.2022.
//

import Foundation
import SwiftUI

extension Color {
    
    struct Domain {
        let backgroundColor = Color.white
        let gridColor = Color.gray
        let promptTextColor = Color.blue
        let crossColorGradient: [Color] = [.yellow, .blue, .yellow, .green]
        let zeroColorGradient: [Color] = [.yellow, .red, .yellow, .orange]
    }
    
    static let domain = Domain()

}
