//
//  Game.swift
//  ChessKnightMovement
//
//  Created by Vagelis Koutkias on 4/21/18.
//  Copyright © 2018 Vagelis Koutkias. All rights reserved.
//

import Foundation

struct MovementGame {

    private let startingSquare: ChessBoardSquare
    private let finnishingSquare: ChessBoardSquare
    private let chessPiece: ChessPiece
    private let maximumMovesAllowed: Int

    // MARK: - LifeCycle

    init(startingSquare: ChessBoardSquare, finnishingSquare: ChessBoardSquare, chessPiece: ChessPiece,
         maximumMovesAllowed: Int) {
        self.startingSquare = startingSquare
        self.finnishingSquare = finnishingSquare
        self.chessPiece = chessPiece
        self.maximumMovesAllowed = maximumMovesAllowed
    }

    // MARK: - Public methods

    func findPaths() -> [ChessBoardSquaresPath] {
        let initialPath = ChessBoardSquaresPath(squares: [startingSquare])
        return findPaths(from: startingSquare, to: finnishingSquare,
                              movesLeft: maximumMovesAllowed, path: initialPath)
    }

    // MARK: - Private methods

    private func findPaths(from: ChessBoardSquare, to: ChessBoardSquare,
                           movesLeft: Int, path: ChessBoardSquaresPath) -> [ChessBoardSquaresPath] {
        var fullFilledPaths = [ChessBoardSquaresPath]()

        let nextMoves = chessPiece.calculateNextMoveSquares(fromSquare: from).filter { !path.containsSquare($0) }
        for nextMove in nextMoves {
            let updatedPath = ChessBoardSquaresPath(squares: path.squares + [nextMove])
            if nextMove == to {
                fullFilledPaths.append(updatedPath)
            } else if movesLeft > 1 {
                let indirectPaths = findPaths(from: nextMove, to: to,
                                              movesLeft: movesLeft - 1, path: updatedPath)
                fullFilledPaths.append(contentsOf: indirectPaths)
            }
        }
        return fullFilledPaths
    }
}
