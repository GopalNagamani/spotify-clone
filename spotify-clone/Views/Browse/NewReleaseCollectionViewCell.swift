//
//  NewReleaseCollectionViewCell.swift
//  spotify-clone
//
//  Created by Chandru A S on 05/12/24.
//

import UIKit

class NewReleaseCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "NewReleaseCollectionViewCell"
    
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
}
