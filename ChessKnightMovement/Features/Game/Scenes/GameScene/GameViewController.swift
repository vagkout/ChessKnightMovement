//
//  GameViewController.swift
//  ChessKnightMovement
//
//  Created by Vagelis Koutkias on 4/22/18.
//  Copyright © 2018 Vagelis Koutkias. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak private var collectionView: UICollectionView!

    enum GameState {
        case nothingSelected
        case selectedStartingSquare(ChessBoardSquare)
        case selectedStartingAndFinnishSquare(ChessBoardSquare, ChessBoardSquare)
    }

    private var gameState: GameState = .nothingSelected

    // MARK: - Private methods

    private func startNewGame() {
        guard case let .selectedStartingAndFinnishSquare(startingSquare, finishingSquare) = gameState else { return }

        let game = MovementGame(startingSquare: startingSquare, finnishingSquare: finishingSquare,
                                chessPiece: Knight(), maximumMovesAllowed: 3)
        let paths = game.findPaths()
        if paths.count > 0 {
            renderPaths(paths)
        } else {
            clearBoard()
        }
    }

    private func renderPaths(_ paths: [ChessBoardSquaresPath]) {
        var previousStepCell: ChessBoardSquareCollectionViewCell?
        let totalSquares = paths.flatMap { $0.squares }
        let totalDuration = Double(totalSquares.count)

        UIView.animateKeyframes(withDuration: totalDuration, delay: 0, options: [], animations: {
            for (index, square) in totalSquares.enumerated() {
                UIView.addKeyframe(withRelativeStartTime: Double(index) / totalDuration, relativeDuration: 1 / totalDuration, animations: {
                    let cell = self.collectionView.cellForItem(at: square.toIndexPath()) as? ChessBoardSquareCollectionViewCell
                    cell?.showChessPiece()
                    previousStepCell?.hideChessPiece()
                    previousStepCell = cell
                })
            }
        }, completion: { _ in
            UIView.animate(withDuration: 0.5) {
                previousStepCell?.hideChessPiece()
                self.clearBoard()
            }
        })
    }

    private func clearBoard() {
        guard case let .selectedStartingAndFinnishSquare(startingSquare, finishingSquare) = gameState else { return }

        let cellStartingSquare = collectionView.cellForItem(at: startingSquare.toIndexPath()) as? ChessBoardSquareCollectionViewCell
        let cellFinnishingSquare = collectionView.cellForItem(at: finishingSquare.toIndexPath()) as? ChessBoardSquareCollectionViewCell

        cellStartingSquare?.hideSelectedView()
        cellFinnishingSquare?.hideSelectedView()

        gameState = .nothingSelected
    }

    private func selectCell(atIndexPath indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? ChessBoardSquareCollectionViewCell
        cell?.showSelectedView()
    }
}

// MARK: - UICollectionViewDataSource

extension GameViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ChessBoardSquareCollectionViewCell.self),
                                                      for: indexPath)
        if indexPath.section % 2 == 0 && indexPath.row % 2 == 0
            || indexPath.section % 2 != 0 && indexPath.row % 2 != 0 {
            cell.backgroundColor = .white
        } else {
            cell.backgroundColor = .brown
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension GameViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let squareWidth = collectionView.frame.width / 8
        return CGSize(width: squareWidth, height: squareWidth)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - UICollectionViewDelegate

extension GameViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch gameState {
        case .nothingSelected:
            selectCell(atIndexPath: indexPath)
            gameState = .selectedStartingSquare(indexPath.toChessBoardSquare())
        case let .selectedStartingSquare(startingSquare):
            selectCell(atIndexPath: indexPath)
            gameState = .selectedStartingAndFinnishSquare(startingSquare, indexPath.toChessBoardSquare())
            startNewGame()
        case .selectedStartingAndFinnishSquare:
            return
        }
    }
}
