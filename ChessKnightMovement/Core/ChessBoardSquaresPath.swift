//
//  MovesPath.swift
//  ChessKnightMovement
//
//  Created by Vagelis Koutkias on 4/21/18.
//  Copyright © 2018 Vagelis Koutkias. All rights reserved.
//

import Foundation

struct ChessBoardSquaresPath {

    var squares = [ChessBoardSquare]()

    // MARK: - Public methods

    func containsSquare(_ square: ChessBoardSquare) -> Bool {
        return squares.contains(square)
    }
}

// MARK: - Equatable

extension ChessBoardSquaresPath: Equatable {

    static func == (lhs: ChessBoardSquaresPath, rhs: ChessBoardSquaresPath) -> Bool {
        return lhs.squares == rhs.squares
    }
}

// MARK: - Hashable

extension ChessBoardSquaresPath: Hashable {

    var hashValue: Int {
        return squares.count
    }
}
