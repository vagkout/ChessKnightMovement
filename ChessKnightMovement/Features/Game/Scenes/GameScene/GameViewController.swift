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

    private var startingSquare: ChessBoardSquare?
    private var finnishingSquare: ChessBoardSquare?

    // MARK: - Private methods

    private func startNewGame() {
        guard let startingSquare = startingSquare, let finishingSquare = finnishingSquare else { return }

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
        guard let startingSquare = startingSquare, let finishingSquare = finnishingSquare else { return }

        let cellStartingSquare = collectionView.cellForItem(at: startingSquare.toIndexPath()) as? ChessBoardSquareCollectionViewCell
        let cellFinnishingSquare = collectionView.cellForItem(at: finishingSquare.toIndexPath()) as? ChessBoardSquareCollectionViewCell

        cellStartingSquare?.hideSelectedView()
        cellFinnishingSquare?.hideSelectedView()

        self.startingSquare = nil
        self.finnishingSquare = nil
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
        if startingSquare == nil {
            startingSquare = indexPath.toChessBoardSquare()
            let cell = collectionView.cellForItem(at: indexPath) as? ChessBoardSquareCollectionViewCell
            cell?.showSelectedView()()
        } else if finnishingSquare == nil {
            finnishingSquare = indexPath.toChessBoardSquare()
            let cell = collectionView.cellForItem(at: indexPath) as? ChessBoardSquareCollectionViewCell
            cell?.showSelectedView()()
            startNewGame()
        }
    }
}
