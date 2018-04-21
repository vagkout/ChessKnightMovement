//
//  KnightTests.swift
//  ChessKnightMovementTests
//
//  Created by Vagelis Koutkias on 4/21/18.
//  Copyright © 2018 Vagelis Koutkias. All rights reserved.
//

import XCTest
@testable import ChessKnightMovement

class KnightTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    func test_calculateAllPossibleNextMoveSquares_WithMiddleSquare_ShouldReturn8Squares() {
        let sut = Knight()

        let middleSquare = ChessBoardSquare(row: 3, column: 3)
        let nextMoveSquares = sut.calculateNextMoveSquares(fromSquare: middleSquare)

        let expectedSquares = [ChessBoardSquare(row: 1, column: 2),
                               ChessBoardSquare(row: 1, column: 4),
                               ChessBoardSquare(row: 5, column: 2),
                               ChessBoardSquare(row: 5, column: 4),
                               ChessBoardSquare(row: 2, column: 1),
                               ChessBoardSquare(row: 4, column: 1),
                               ChessBoardSquare(row: 2, column: 5),
                               ChessBoardSquare(row: 4, column: 5)]
        XCTAssertEqual(nextMoveSquares, expectedSquares)
    }

    func test_calculateAllPossibleNextMoveSquares_WithBottomLeftSquare_ShouldFilterInvalidSquares() {
        let sut = Knight()

        let middleSquare = ChessBoardSquare(row: 7, column: 0)
        let nextMoveSquares = sut.calculateNextMoveSquares(fromSquare: middleSquare)

        let expectedSquares = [ChessBoardSquare(row: 5, column: 1),
                               ChessBoardSquare(row: 6, column: 2)]
        XCTAssertEqual(nextMoveSquares, expectedSquares)
    }
}
