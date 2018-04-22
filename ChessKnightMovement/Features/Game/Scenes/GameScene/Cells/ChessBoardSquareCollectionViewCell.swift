//
//  ChessBoardSquareCollectionViewCell.swift
//  ChessKnightMovement
//
//  Created by Vagelis Koutkias on 4/22/18.
//  Copyright © 2018 Vagelis Koutkias. All rights reserved.
//

import UIKit

class ChessBoardSquareCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak private var chessPieceImageView: UIImageView!
    @IBOutlet weak private var selectionView: UIView!

    // MARK: - Overriden methods

    override func awakeFromNib() {
        selectionView.alpha = 0
        chessPieceImageView.alpha = 0
    }

    // MARK: - Public methods

    func showChessPiece() {
        chessPieceImageView.alpha = 1
    }

    func hideChessPiece() {
        chessPieceImageView.alpha = 0
    }

    func showSelectedView() {
        selectionView.alpha = 1
    }

    func hideSelectedView() {
        selectionView.alpha = 0
        chessPieceImageView.alpha = 0
    }
}
