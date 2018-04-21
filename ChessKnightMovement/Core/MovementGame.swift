//
//  Game.swift
//  ChessKnightMovement
//
//  Created by Vagelis Koutkias on 4/21/18.
//  Copyright © 2018 Vagelis Koutkias. All rights reserved.
//

import Foundation

struct MovementGame {

    let startingSquare: ChessBoardSquare
    let finnishingSquare: ChessBoardSquare
    let chessPiece: ChessPiece
    let maximumMovesAllowed: Int

    // MARK: - Public methods

    func calculatePaths() -> [MovesPath] {
        return calculatePaths(fromSquare: startingSquare, toSquare: finnishingSquare, movesAllowed: maximumMovesAllowed, path: MovesPath())
    }

    // MARK: - Private methods

    func calculatePaths(fromSquare: ChessBoardSquare, toSquare: ChessBoardSquare, movesAllowed: Int, path: MovesPath) -> [MovesPath] {
        let nextMoveSquares = chessPiece.calculateNextMoveSquares(fromSquare: fromSquare)
        var fullFilledPaths = [MovesPath]()
        for nextMoveSquare in nextMoveSquares {
            let newPath = MovesPath(moves: path.moves + [nextMoveSquare])
            if nextMoveSquare == toSquare {
                fullFilledPaths.append(newPath)
            } else if movesAllowed > 1 {
                let nextMoveSquares = calculatePaths(fromSquare: nextMoveSquare, toSquare: toSquare,
                                                     movesAllowed: movesAllowed - 1, path: newPath)
                fullFilledPaths.append(contentsOf: nextMoveSquares)
            }
        }
        return fullFilledPaths
    }
}
