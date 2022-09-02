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
    
    // let ai plays as cross
    private let identifier = Player.cross
    
    private let scores: [GameBoard.GameResult: Int] = [
        .draw: 0,
        .crossWin: 1,
        .zeroWin: -1
    ]
    private var cancellables: Set<AnyCancellable> = []
        
    init(_ gameBoard: GameBoard) {
        gameBoard.$currentPlayer
            .filter { [weak self] _ in
                self?.isEnabled == true
            }
            .filter {
                $0 == .cross
            }
            .sink { _ in
                // make turn
            }
            .store(in: &cancellables)
    }
    
    func minimax() {
        
    }
    
}

/*
 function minimax(position, depth, alpha, beta, maximizingPlayer) {
     if depth == 0 or gameOver in position {
         return static evalution of position
     }

     if maximizingPlayer {
         maxEval = -infinity
         forEach child in position {
             eval = minimax(child, depth - 1, alpha, beta, false)
             maxEval = max(maxEval, eval)
             alpha = max(alpha, eval)
             if beta <= alpha {
                 break
             }
         }
         return maxEval
     } else {
         minEval = +infinity
         forEach child in position {
             eval = minimax(child, depth - 1, alpha, beta, true)
             minEval = min(minEval, eval)
             beta = min(beta, eval)
             if beta <= alpha {
                 break
             }
         }
         return minEval
     }
 }

 // initial call
 minimax(currentPosition, 3, -inf, true)
 */
