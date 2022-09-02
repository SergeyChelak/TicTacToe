//
//  TicTacToeApp.swift
//  TicTacToe
//
//  Created by Serhii Chelak on 02.09.2022.
//

import SwiftUI

@main
struct TicTacToeApp: App {
    private let gameBoard = GameBoard()
    
    var body: some Scene {
        WindowGroup {
            GameView(gameBoard: gameBoard)
        }
    }
}
