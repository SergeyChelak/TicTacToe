//
//  GameBoard.swift
//  TicTacToe
//
//  Created by Serhii Chelak on 02.09.2022.
//

import Foundation

class GameBoard: ObservableObject {        
    
    static let boardSize = 3
    static let target = 3
    
    @Published private(set) var board: Board = .empty(boardSize)
    @Published private(set) var currentPlayer: Player = .random
    @Published private(set) var gameState: GameState = .playing
    
    func reset() {
        board = .empty(Self.boardSize)
        currentPlayer = Player.random
        gameState = .playing
    }
    
    func isAllowedPosition(row: Int, col: Int) -> Bool {
        guard case .playing = gameState,
              0..<Self.boardSize ~= row,
              0..<Self.boardSize ~= col else {
            return false
        }
        return board[row][col] == .empty
    }
    
    func get(row: Int, col: Int) -> CellState {
        board[row][col]
    }
    
    func makeMove(row: Int, col: Int) {
        guard isAllowedPosition(row: row, col: col) else {
            return
        }
        board[row][col] = currentPlayer.cellState
        gameState = board.calculateGameState()        
        currentPlayer = currentPlayer.opponent
    }    
}
