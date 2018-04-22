//
//  ChessBoardSquare+IndexPath.swift
//  ChessKnightMovement
//
//  Created by Vagelis Koutkias on 4/22/18.
//  Copyright © 2018 Vagelis Koutkias. All rights reserved.
//

import Foundation

extension ChessBoardSquare {

    func toIndexPath() -> IndexPath {
        return IndexPath(row: row, section: column)
    }
}
