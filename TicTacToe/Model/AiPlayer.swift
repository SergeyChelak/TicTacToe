//
//  AiPlayer.swift
//  TicTacToe
//
//  Created by Serhii Chelak on 03.09.2022.
//

import Combine
import Foundation

class AiPlayer {
    private var isEnabled = true
    
    private let infinity = 10
    private let count = GameBoard.boardSize
    
    // let ai plays as cross
    private let identifier = Player.cross
    
    private var cancellables: Set<AnyCancellable> = []
    
    private weak var gameBoard: GameBoard?
    
    init(_ gameBoard: GameBoard) {
        self.gameBoard = gameBoard
        gameBoard.$currentPlayer
            .filter { [weak self] _ in
                self?.isEnabled == true
            }
            .filter { [weak self] player in
                player == self?.identifier
            }
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    self?.makeMove()
                }
            }
            .store(in: &cancellables)
    }
    
    private func makeMove() {
        guard let gameBoard = gameBoard else {
            fatalError("Game board didn't set")
        }
        guard gameBoard.gameState == .playing else {
            return
        }
        assert(gameBoard.currentPlayer == identifier, "Incorrent AI player")
        var board = gameBoard.board
        let state = identifier.cellState
        var bestPosition: (Int, Int)?
        var bestResult = Int.min
        for i in 0..<count {
            for j in 0..<count {
                if board[i][j] == .empty {
                    board[i][j] = state
                    let result = minimax(&board, Int.min, Int.max, isMaximizing: false)
                    if result > bestResult {
                        bestResult = result
                        bestPosition = (i, j)
                    }
                    board[i][j] = .empty
                }
            }
        }
        
        guard let (row, col) = bestPosition else {
            fatalError("Cound find the best position")
        }
        gameBoard.makeMove(row: row, col: col)
    }
    
    private func minimax(_ board: inout Board, _ alpha: Int, _ beta: Int, isMaximizing: Bool) -> Int {
        switch board.calculateGameState() {
        case .playing:
            break
        case .draw:
            return 0
        case .crossWin:
            return 1
        case .zeroWin:
            return -1
        }
        
        var alpha = alpha
        var beta = beta
        
        if isMaximizing {
            let playerState = identifier.cellState
            var maxScore = -infinity
            for row in 0..<count {
                for col in 0..<count {
                    if board[row][col] == .empty {
                        board[row][col] = playerState
                        let score = minimax(&board, alpha, beta, isMaximizing: false)
                        maxScore = max(maxScore, score)
                        board[row][col] = .empty
                        // optimisation
                        alpha = max(alpha, score)
                        if beta <= alpha {
                            return maxScore
                        }
                    }
                }
            }
            return maxScore
        } else {
            var minScore = infinity
            let playerState = identifier.opponent.cellState
            for row in 0..<count {
                for col in 0..<count {
                    if board[row][col] == .empty {
                        board[row][col] = playerState
                        let score = minimax(&board, alpha, beta, isMaximizing: true)
                        minScore = min(minScore, score)
                        board[row][col] = .empty
                        // optimisation
                        beta = min(beta, score)
                        if beta <= alpha {
                            return minScore
                        }
                    }
                }
            }
            return minScore
        }
    }
    
}
