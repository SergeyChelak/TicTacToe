//
//  GameBoard.swift
//  TicTacToe
//
//  Created by Serhii Chelak on 02.09.2022.
//

import Foundation

class GameBoard: ObservableObject {
    enum CellState {
        case empty, cross, zero
    }
    
    enum Player {
        case cross, zero
        
        static var random: Self {
            Int.random(in: 0...1) > 0 ? .cross : .zero
        }
        
        var opponent: Player {
            self == .cross ? .zero : .cross
        }
        
        var cellState: CellState {
            self == .cross ? .cross : .zero
        }
    }
    
    enum GameResult {
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
    
    typealias Board = [[CellState]]
    
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
        let deltas = [
            [(1, 0), (-1, 0)],
            [(0, 1), (0, -1)],
            [(1, 1), (-1, -1)],
            [(1, -1), (-1, 1)]
        ]
        for delta in deltas {
            var total = -1
            for direction in delta {
                total += sum(row: row, col: col, dx: direction.0, dy: direction.1)
            }
            if total == Self.target {
                return currentPlayer
            }
        }
        return nil
    }
    
    private func sum(row: Int, col: Int, dx: Int, dy: Int) -> Int {
        guard row >= 0 && row < Self.boardSize && col >= 0 && col < Self.boardSize else {
            return 0
        }
        guard board[row][col] == currentPlayer.cellState else {
            return 0
        }
        return 1 + sum(row: row + dx, col: col + dy, dx: dx, dy: dy)
    }
    
    private func hasMoreMoves() -> Bool {
        for row in board {
            for cell in row {
                if cell == .empty {
                    return true
                }
            }
        }
        return false
    }
    
    private static func emptyBoard(_ size: Int) -> Board {
        Board.init(repeating: [CellState].init(repeating: .empty, count: size),
                   count: size)
    }
    
}
