//
//  ChessSquare.swift
//  ChessKnightMovement
//
//  Created by Vagelis Koutkias on 4/21/18.
//  Copyright © 2018 Vagelis Koutkias. All rights reserved.
//

import Foundation

struct ChessBoardSquare {
    let row: Int
    let column: Int

    // MARK: - Public methods

    func squareByAdding(row: Int, column: Int) -> ChessBoardSquare {
        return ChessBoardSquare(row: self.row + row, column: self.column + column)
    }

    func isValid() -> Bool {
        return row >= 0 &&  row <= 7
            && column >= 0 && column <= 7
    }
}

// MARK: - Equatable

extension ChessBoardSquare: Equatable {

    static func == (lhs: ChessBoardSquare, rhs: ChessBoardSquare) -> Bool {
        return lhs.row == rhs.row && lhs.column == rhs.column
    }
}
