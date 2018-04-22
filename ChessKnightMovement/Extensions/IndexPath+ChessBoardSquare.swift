//
//  IndexPath+ChessBoardSquare.swift
//  ChessKnightMovement
//
//  Created by Vagelis Koutkias on 4/22/18.
//  Copyright © 2018 Vagelis Koutkias. All rights reserved.
//

import Foundation

extension IndexPath {

    func toChessBoardSquare() -> ChessBoardSquare {
        return ChessBoardSquare(row: row, column: section)
    }
}
