//
//  MovesPath.swift
//  ChessKnightMovement
//
//  Created by Vagelis Koutkias on 4/21/18.
//  Copyright © 2018 Vagelis Koutkias. All rights reserved.
//

import Foundation

struct MovesPath {
    var moves = [ChessBoardSquare]()
}

// MARK: - Equatable

extension MovesPath: Equatable {

    static func == (lhs: MovesPath, rhs: MovesPath) -> Bool {
        return lhs.moves == rhs.moves
    }
}

// MARK: - Hashable

extension MovesPath: Hashable {

    var hashValue: Int {
        return moves.count
    }
}
