//
//  ChessBoardSquare.swift
//  ChessKnightMovementTests
//
//  Created by Vagelis Koutkias on 4/21/18.
//  Copyright © 2018 Vagelis Koutkias. All rights reserved.
//

import XCTest

@testable import ChessKnightMovement

class ChessBoardSquareTests: XCTestCase {

    func testIsValid_WithOutOfBoundsSquare_ShouldReturnInvalid() {
        let sut = ChessBoardSquare(row: -1, column: 0)

        XCTAssertFalse(sut.isValid())
    }

    func testIsValid_WithPositiveOutOfBoundsSquare_ShouldReturnInvalid() {
        let sut = ChessBoardSquare(row: 8, column: 0)

        XCTAssertFalse(sut.isValid())
    }

    func testIsValid_WithInboundsSquare_ShouldReturnValid() {
        let sut = ChessBoardSquare(row: 0, column: 0)

        XCTAssertTrue(sut.isValid())
    }

    func testSquareByAdding_WithPositiveAddition_ShouldReturnCorrectSquare() {
        let sut = ChessBoardSquare(row: 5, column: 5)

        let resultSquare = sut.squareByAdding(row: 2, column: 3)

        let expectedSquare = ChessBoardSquare(row: 7, column: 8)
        XCTAssertEqual(resultSquare, expectedSquare)
    }
}
