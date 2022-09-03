//
//  TicTacToeApp.swift
//  TicTacToe
//
//  Created by Serhii Chelak on 02.09.2022.
//

import SwiftUI

@main
struct TicTacToeApp: App {
    private let gameBoard: GameBoard
    private let aiPlayer: AiPlayer
    
    init() {
        let gameBoard = GameBoard()
        let aiPlayer = AiPlayer(gameBoard)
        
        self.gameBoard = gameBoard
        self.aiPlayer = aiPlayer
    }
    
    
    var body: some Scene {
        WindowGroup {
            GameView(gameBoard: gameBoard)
        }
    }
}
