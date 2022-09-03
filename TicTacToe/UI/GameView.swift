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
            Text(prompt)
                .font(.system(size: 35))
                .foregroundColor(Color.domain.promptTextColor)
                .padding()
            
            BoardView(gameBoard: gameBoard, backgroundColor: Color.domain.backgroundColor)
                .frame(width: 350, height: 350, alignment: .center)
            
            Button(action: {
                gameBoard.reset()
            }) {
                Image("NewGameImage")
                    .resizable()
                    .frame(width: 130, height: 130, alignment: .center)
            }
        }
        .frame(minWidth: 100, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
        .background(Color.domain.backgroundColor)
    }
    
    private var prompt: String {
        switch gameBoard.gameState {
        case .playing:
            return playerPrompt
        case .draw:
            return "Draw"
        case .crossWin:
            return "Cross win"
        case .zeroWin:
            return "Zero win"
        }
    }
    
    private var playerPrompt: String {
        switch gameBoard.currentPlayer {
        case .cross:
            return "Wait..."
        case .zero:
            return "Your turn"
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        let gameBoard = GameBoard()
        GameView(gameBoard: gameBoard)
    }
}
