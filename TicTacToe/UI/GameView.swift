//
//  GameView.swift
//  TicTacToe
//
//  Created by Serhii Chelak on 02.09.2022.
//

import SwiftUI

struct GameView: View {
    @StateObject var gameBoard: GameBoard
    
    var body: some View {
        VStack {
            Text("Current Player: \(playerName(gameBoard.currentPlayer))")
                .padding()
            
            BoardView(gameBoard: gameBoard)
                .frame(width: 350, height: 350, alignment: .center)
            
            Text(gameStateMessage(gameBoard.gameState))
                .padding()
            
            Button("New Game") {
                gameBoard.reset()
            }
            
        }
        .frame(minWidth: 100, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
        .background(Color.green)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        let gameBoard = GameBoard()
        GameView(gameBoard: gameBoard)
    }
}

private func playerName(_ player: GameBoard.Player) -> String {
    switch player {
    case .cross:
        return "Cross"
    case .zero:
        return "Zero"
    }
}

private func gameStateMessage(_ state: GameBoard.GameState) -> String {
    switch state {
    case .goingOn:
        return "Make your turn"
    case .over(let result):
        return gameOverMessage(result)
    }
}

private func gameOverMessage(_ gameResult: GameBoard.GameResult) -> String {
    switch gameResult {
    case .draw:
        return "Draw"
    case .crossWin:
        return "Cross win"
    case .zeroWin:
        return "Zero win"
    }
}
