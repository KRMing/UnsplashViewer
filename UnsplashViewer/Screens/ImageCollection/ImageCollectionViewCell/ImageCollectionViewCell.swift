//
//  ImageCollectionViewCell.swift
//  UnsplashViewer
//
//  Created by Ming on 2022/06/17.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
  static public let className = String(describing: ImageCollectionViewCell.self)
  
  @IBOutlet weak var view: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    // Initialization code
    view.layer.borderColor = UIColor.black.cgColor
    view.layer.borderWidth = 0
  }
  
  public func bind(to data: ImageCollection) {
    titleLabel.text = String(data.image.value)
  }
}
