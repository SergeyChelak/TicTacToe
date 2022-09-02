//
//  GameBoard.swift
//  TicTacToe
//
//  Created by Serhii Chelak on 02.09.2022.
//

import Foundation

class GameBoard: ObservableObject {    
    
    enum GameResult: Int {
        case draw, crossWin, zeroWin
    }
    
    enum GameState {
        case goingOn,
             over(GameResult)
        
        static var draw: Self {
            .over(.draw)
        }
        
        static func winner(_ player: Player) -> Self {
            switch player {
            case .cross:
                return .over(.crossWin)
            case .zero:
                return .over(.zeroWin)
            }
        }
    }    
    
    static let boardSize = 3
    static let target = 3
    
    @Published private var board: Board = emptyBoard(boardSize)
    @Published private(set) var currentPlayer: Player = .random
    @Published private(set) var gameState: GameState = .goingOn
    
    func reset() {
        board = Self.emptyBoard(Self.boardSize)
        currentPlayer = Player.random
        gameState = .goingOn
    }
    
    func isAllowedPosition(row: Int, col: Int) -> Bool {
        guard case .goingOn = gameState else {
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
        if let winner = checkForWinner(row: row, col: col) {
            gameState = .winner(winner)
            return
        }
        if hasMoreMoves() {
            currentPlayer = currentPlayer.opponent
        } else {
            gameState = .draw
        }
    }
    
    private func checkForWinner(row: Int, col: Int) -> Player? {
        board.checkForWinner(row: row, col: col, target: Self.target)
    }
        
    private func hasMoreMoves() -> Bool {
        board.hasMoreMoves
    }
    
    private static func emptyBoard(_ size: Int) -> Board {
        Board.init(repeating: [CellState].init(repeating: .empty, count: size),
                   count: size)
    }
    
}
