//
//  Knight.swift
//  ChessKnightMovement
//
//  Created by Vagelis Koutkias on 4/21/18.
//  Copyright © 2018 Vagelis Koutkias. All rights reserved.
//

import Foundation

struct Knight {

    // MARK: - Private methods

    private func calculateAllPossibleNextMoveSquares(fromSquare: ChessBoardSquare) -> [ChessBoardSquare] {
        let nextMoveSquares = [fromSquare.squareByAdding(row: -2, column: -1),
                               fromSquare.squareByAdding(row: -2, column: 1),
                               fromSquare.squareByAdding(row: 2, column: -1),
                               fromSquare.squareByAdding(row: 2, column: 1),
                               fromSquare.squareByAdding(row: -1, column: -2),
                               fromSquare.squareByAdding(row: 1, column: -2),
                               fromSquare.squareByAdding(row: -1, column: 2),
                               fromSquare.squareByAdding(row: 1, column: 2)
                            ]
        return nextMoveSquares
    }
}

// MARK: - ChessPiece

extension Knight: ChessPiece {

    func calculateNextMoveSquares(fromSquare: ChessBoardSquare) -> [ChessBoardSquare] {
        let possibleNextMoveSquares = calculateAllPossibleNextMoveSquares(fromSquare: fromSquare)
        let validSquares = possibleNextMoveSquares.filter { $0.isValid() }
        return validSquares
    }
}
