//
//  MovementGameTests.swift
//  ChessKnightMovementTests
//
//  Created by Vagelis Koutkias on 4/21/18.
//  Copyright © 2018 Vagelis Koutkias. All rights reserved.
//

import XCTest
@testable import ChessKnightMovement

class MovementGameTests: XCTestCase {

    func test_calculatePaths_WithOneValidMove_ShouldFindOne() {
        let startingSquare = ChessBoardSquare(row: 4, column: 4)
        let finnishingSquare = ChessBoardSquare(row: 6, column: 3)

        let sut = MovementGame(startingSquare: startingSquare, finnishingSquare: finnishingSquare, chessPiece: Knight(), maximumMovesAllowed: 1)
        let calculatedPaths = sut.calculatePaths()
        let expectedPaths = [MovesPath(moves: [finnishingSquare])]

        XCTAssertEqual(calculatedPaths, expectedPaths)
    }

    func test_calculatePaths_WithOneMoveAllowedAndFinnishingSquareUnReachable_ShouldFindNone() {
        let startingSquare = ChessBoardSquare(row: 0, column: 0)
        let finnishingSquare = ChessBoardSquare(row: 7, column: 7)

        let sut = MovementGame(startingSquare: startingSquare, finnishingSquare: finnishingSquare, chessPiece: Knight(), maximumMovesAllowed: 1)
        let calculatedPaths = sut.calculatePaths()

        XCTAssertTrue(calculatedPaths.count == 0)
    }

    func test_calculatePaths_WithOneMoveAllowed_ShouldNotReachSquareTwoMovesAway() {
        let startingSquare = ChessBoardSquare(row: 4, column: 4)
        let finnishingSquare = ChessBoardSquare(row: 1, column: 3)

        let sut = MovementGame(startingSquare: startingSquare, finnishingSquare: finnishingSquare, chessPiece: Knight(), maximumMovesAllowed: 1)
        let calculatedPaths = Set(sut.calculatePaths())

        XCTAssertTrue(calculatedPaths.count == 0)
    }

    func test_calculatePaths_WithTwoValidMovesAndFinnishingSquareReachable_ShouldReach() {
        let startingSquare = ChessBoardSquare(row: 4, column: 4)
        let finnishingSquare = ChessBoardSquare(row: 1, column: 3)

        let sut = MovementGame(startingSquare: startingSquare, finnishingSquare: finnishingSquare, chessPiece: Knight(), maximumMovesAllowed: 2)
        let calculatedPaths = Set(sut.calculatePaths())
        let expectedPaths = Set([MovesPath(moves: [ChessBoardSquare(row: 3, column: 2), finnishingSquare]),
                                 MovesPath(moves: [ChessBoardSquare(row: 2, column: 5), finnishingSquare])])

        XCTAssertEqual(calculatedPaths, expectedPaths)
    }
}
