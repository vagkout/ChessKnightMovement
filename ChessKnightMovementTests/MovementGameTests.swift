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

    func test_calculatePaths_WithOneValidMove_ShouldFindIt() {
        let startingSquare = ChessBoardSquare(row: 4, column: 4)
        let finnishingSquare = ChessBoardSquare(row: 6, column: 3)
        let sut = MovementGame(startingSquare: startingSquare, finnishingSquare: finnishingSquare, chessPiece: Knight(), maximumMovesAllowed: 1)

        let calculatedPaths = sut.findPaths()

        let expectedPaths = [ChessBoardSquaresPath(squares: [startingSquare, finnishingSquare])]
        XCTAssertEqual(calculatedPaths, expectedPaths)
    }

    func test_calculatePaths_WithOneMoveAndFinnishingSquareUnreachable_ShouldFindNone() {
        let startingSquare = ChessBoardSquare(row: 0, column: 0)
        let finnishingSquare = ChessBoardSquare(row: 7, column: 7)
        let sut = MovementGame(startingSquare: startingSquare, finnishingSquare: finnishingSquare, chessPiece: Knight(), maximumMovesAllowed: 1)

        let calculatedPaths = sut.findPaths()

        XCTAssertTrue(calculatedPaths.count == 0)
    }

    func test_calculatePaths_WithOneMove_ShouldNotReachSquareTwoMovesAway() {
        let startingSquare = ChessBoardSquare(row: 4, column: 4)
        let finnishingSquare = ChessBoardSquare(row: 1, column: 3)
        let sut = MovementGame(startingSquare: startingSquare, finnishingSquare: finnishingSquare, chessPiece: Knight(), maximumMovesAllowed: 1)

        let calculatedPaths = Set(sut.findPaths())

        XCTAssertTrue(calculatedPaths.count == 0)
    }

    func test_calculatePaths_WithTwoMovesAndFinnishingSquareReachable_ShouldReach() {
        let startingSquare = ChessBoardSquare(row: 4, column: 4)
        let finnishingSquare = ChessBoardSquare(row: 1, column: 3)
        let sut = MovementGame(startingSquare: startingSquare, finnishingSquare: finnishingSquare, chessPiece: Knight(), maximumMovesAllowed: 2)

        let calculatedPaths = Set(sut.findPaths())

        let expectedPaths = Set([ChessBoardSquaresPath(squares: [startingSquare, ChessBoardSquare(row: 3, column: 2), finnishingSquare]),
                                 ChessBoardSquaresPath(squares: [startingSquare, ChessBoardSquare(row: 2, column: 5), finnishingSquare])])
        XCTAssertEqual(calculatedPaths, expectedPaths)
    }

    func test_calculatePaths_WithThreeMoves_ShouldNotContainPathsWithDuplicateSquares() {
        let startingSquare = ChessBoardSquare(row: 4, column: 4)
        let finnishingSquare = ChessBoardSquare(row: 6, column: 3)
        let sut = MovementGame(startingSquare: startingSquare, finnishingSquare: finnishingSquare, chessPiece: Knight(), maximumMovesAllowed: 3)

        let calculatedPaths = sut.findPaths()

        for path in calculatedPaths {
            let uniqueSquares = Set(path.squares)
            if path.squares.count != uniqueSquares.count {
                XCTFail("Found path with duplicate squares")
            }
        }
    }
}
