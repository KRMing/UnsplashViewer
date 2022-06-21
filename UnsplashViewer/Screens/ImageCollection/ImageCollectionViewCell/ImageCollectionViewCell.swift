//
//  ImageCollectionViewCell.swift
//  UnsplashViewer
//
//  Created by Ming on 2022/06/17.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class ImageCollectionViewCell: UICollectionViewCell {
  static public let className = String(describing: ImageCollectionViewCell.self)
  
  @IBOutlet weak var view: UIView!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var overlayView: UIView!
  @IBOutlet weak var likesLabel: UILabel!
  
  private let disposeBag = DisposeBag()
  public let isOverlayOn = BehaviorRelay<Bool>(value: false)
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    /// Initialization code
    view.layer.borderColor = UIColor.black.cgColor
    view.layer.borderWidth = 0
    
    isOverlayOn
      .asDriver(onErrorJustReturn: false)
      .drive { [weak self] isOverlayOn in
        self?.overlayView.isHidden = !isOverlayOn
      }
      .disposed(by: disposeBag)
  }
  
  public func bind(to data: ImageCollection) {
    imageView.kf.setImage(
      with: URL(string: data.image.imageURL),
      options: [.transition(.fade(0.2))]
    )
    
    likesLabel.text = "♥︎ \(data.image.likes)"
  }
}
