//
//  BoardView.swift
//  TicTacToe
//
//  Created by Serhii Chelak on 02.09.2022.
//

import SwiftUI

struct BoardView: View {
    private enum DrawMode: CaseIterable {
        case cross, zero
        
        var colorGradient: [Color] {
            switch self {
            case .cross:
                return Color.domain.crossColorGradient
            case .zero:
                return Color.domain.zeroColorGradient
            }
        }
        
        func corresponds(_ cell: CellState) -> Bool {
            if self == .cross && cell == .cross {
                return true
            }
            if self == .zero && cell == .zero {
                return true
            }
            return false
        }
    }
    
    
    let shapeOffset: CGFloat = 10.0
    
    @ObservedObject var gameBoard: GameBoard
    let backgroundColor: Color
    
    var body: some View {
        GeometryReader { geometry in
            // draw grid
            let width = geometry.size.width
            let height = geometry.size.height
            let dx = width / CGFloat(GameBoard.boardSize)
            let dy = height / CGFloat(GameBoard.boardSize)
            ZStack {
                Rectangle()
                    .fill(backgroundColor)
                    .frame(width: width, height: height, alignment: .center)
                
                Path { path in
                    for i in 1..<GameBoard.boardSize {
                        do {
                            let x = CGFloat(i) * dx
                            path.move(to: CGPoint(x: x, y: 0))
                            path.addLine(to: CGPoint(x: x, y: height))
                        }
                        do {
                            let y = CGFloat(i) * dy
                            path.move(to: CGPoint(x: 0, y: y))
                            path.addLine(to: CGPoint(x: width, y: y))
                        }
                    }
                }.stroke(Color.domain.gridColor, style: StrokeStyle(lineWidth: 2, lineCap: .round))
                
                ForEach(DrawMode.allCases, id: \.self) { drawOption in
                    Path { path in
                        for row in 0..<GameBoard.boardSize {
                            for col in 0..<GameBoard.boardSize {
                                let cellState = gameBoard.get(row: row, col: col)
                                guard drawOption.corresponds(cellState) else { continue }
                                let gcRow = CGFloat(row)
                                let gcCol = CGFloat(col)
                                
                                let topLeft = CGPoint(x: gcRow * dx + shapeOffset,
                                                      y: gcCol * dy + shapeOffset)
                                
                                let topRight = CGPoint(x: dx + gcRow * dx - shapeOffset,
                                                       y: gcCol * dy + shapeOffset)
                                
                                let bottomRight = CGPoint(x: dx + gcRow * dx - shapeOffset,
                                                          y: dy + gcCol * dy - shapeOffset)
                                
                                let bottomLeft = CGPoint(x: gcRow * dx + shapeOffset,
                                                         y: dy + gcCol * dy - shapeOffset)
                                
                                switch cellState {
                                case .cross:
                                    path.move(to: topLeft)
                                    path.addLine(to: bottomRight)
                                    path.move(to: topRight)
                                    path.addLine(to: bottomLeft)
                                case .zero:
                                    let rect = CGRect(x: topLeft.x, y: topLeft.y,
                                                      width: topRight.x - topLeft.x,
                                                      height: bottomLeft.y - topLeft.y)
                                    path.addEllipse(in: rect)
                                default:
                                    break
                                }
                            }
                        }
                    }.stroke(
                        LinearGradient(gradient: Gradient(colors: drawOption.colorGradient),
                                       startPoint: .leading,
                                       endPoint: .trailing),
                        style: StrokeStyle(lineWidth: 4, lineCap: .round))
                }
                
            }.gesture(TapLocationGesture().onEnded { point in
                let row = Int(point.x / dx)
                let col = Int(point.y / dy)
                gameBoard.makeMove(row: row, col: col)
            })
        }
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView(gameBoard: GameBoard(), backgroundColor: Color.blue)
    }
}
