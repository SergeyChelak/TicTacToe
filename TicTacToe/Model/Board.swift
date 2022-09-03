//
//  Board.swift
//  TicTacToe
//
//  Created by Serhii Chelak on 03.09.2022.
//

import Foundation

enum CellState {
    case empty, cross, zero
}

enum GameState {
    case playing,
         draw,
         crossWin,
         zeroWin
        
    static func winner(_ cellState: CellState) -> Self {
        switch cellState {
        case .cross:
            return .crossWin
        case .zero:
            return .zeroWin
        default:
            return .playing
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
    static func empty(_ size: Int) -> Board {
        Board.init(repeating: [CellState].init(repeating: .empty, count: size),
                   count: size)
    }
        
    func calculateGameState() -> GameState {
        for i in 0..<count {
            if isWinnerLine(self[i][0], self[i][1], self[i][2]) {
                return .winner(self[i][0])
            }
            if isWinnerLine(self[0][i], self[1][i], self[2][i]) {
                return .winner(self[0][i])
            }
        }
        if isWinnerLine(self[0][0], self[1][1], self[2][2]) {
            return .winner(self[0][0])
        }
        if isWinnerLine(self[2][0], self[1][1], self[0][2]) {
            return .winner(self[2][0])
        }
        for i in 0..<count {
            for j in 0..<count {
                if self[i][j] == .empty {
                    return .playing
                }
            }
        }
        return .draw
    }
    
    private func isWinnerLine(_ a: CellState, _ b: CellState, _ c: CellState) -> Bool {
        return a == b && b == c && a != .empty
    }
        
}
