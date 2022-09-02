//
//  Board.swift
//  TicTacToe
//
//  Created by Serhii Chelak on 03.09.2022.
//

import Foundation

enum CellState {
    case empty, cross, zero
    
    var player: Player? {
        switch self {
        case .cross:
            return .cross
        case .zero:
            return .zero
        default:
            return nil
        }
    }
}

typealias Board = [[CellState]]

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

extension Board {
    func checkForWinner(row: Int, col: Int, target: Int) -> Player? {
        guard let currentPlayer = self[row][col].player else {
            return nil
        }
        let deltas = [
            [(1, 0), (-1, 0)],
            [(0, 1), (0, -1)],
            [(1, 1), (-1, -1)],
            [(1, -1), (-1, 1)]
        ]
        for delta in deltas {
            var total = -1
            for direction in delta {
                total += sum(row: row, col: col, dx: direction.0, dy: direction.1, player: currentPlayer)
            }
            if total == target {
                return currentPlayer
            }
        }
        return nil
    }
    
    private func sum(row: Int, col: Int, dx: Int, dy: Int, player: Player) -> Int {
        guard row >= 0 && row < count,
              col >= 0 && col < self[row].count else {
            return 0
        }
        guard self[row][col] == player.cellState else {
            return 0
        }
        return 1 + sum(row: row + dx, col: col + dy, dx: dx, dy: dy, player: player)
    }
    
    var hasMoreMoves: Bool {
        for row in self {
            for cell in row {
                if cell == .empty {
                    return true
                }
            }
        }
        return false
    }
}
