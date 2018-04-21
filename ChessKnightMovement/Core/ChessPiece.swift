//
//  ChessPiece.swift
//  ChessKnightMovement
//
//  Created by Vagelis Koutkias on 4/21/18.
//  Copyright © 2018 Vagelis Koutkias. All rights reserved.
//

import Foundation

protocol ChessPiece {

    func calculateNextMoveSquares(fromSquare: ChessBoardSquare) -> [ChessBoardSquare]
}
