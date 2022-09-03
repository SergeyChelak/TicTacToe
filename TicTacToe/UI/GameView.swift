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
                .font(.system(size: 25))
                .foregroundColor(Color.domain.promptTextColor)
                .padding()
                .shadow(color: Color.gray, radius: 5.0, x: 5.0, y: 5.0)
            
            BoardView(gameBoard: gameBoard, backgroundColor: Color.domain.backgroundColor)
                .frame(width: 350, height: 350, alignment: .center)
            
            Button(action: {
                gameBoard.reset()
            }) {
                Image("NewGameImage")
                    .resizable()
                    .frame(width: 100, height: 100, alignment: .center)
            }.shadow(color: Color.gray, radius: 5.0, x: 5.0, y: 5.0)
            
        }
        .frame(minWidth: 100, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
        .background(Color.domain.backgroundColor)
    }
    
    private var prompt: String {
        switch gameBoard.gameState {
        case .playing:
            return "Current Player: \(currentPlayer)"
        case .draw:
            return "Draw"
        case .crossWin:
            return "Cross win"
        case .zeroWin:
            return "Zero win"
        }
    }
    
    private var currentPlayer: String {
        switch gameBoard.currentPlayer {
        case .cross:
            return "Cross"
        case .zero:
            return "Zero"
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        let gameBoard = GameBoard()
        GameView(gameBoard: gameBoard)
    }
}
