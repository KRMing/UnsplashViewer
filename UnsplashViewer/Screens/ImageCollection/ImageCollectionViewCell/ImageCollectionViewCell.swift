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
  public static let className = String(describing: ImageCollectionViewCell.self)
  
  @IBOutlet weak var view: UIView!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var overlayView: UIView!
  @IBOutlet weak var likesLabel: UILabel!
  
  private var disposeBag = DisposeBag()
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    /// Initialization code
    view.layer.borderColor = UIColor.black.cgColor
    view.layer.borderWidth = 0
    overlayView.isHidden = true
  }
  
  override func prepareForReuse() {
    /// Reset expired subscriptions
    disposeBag = DisposeBag()
  }
  
  public func bind(to data: ImageCollectionDataSourceType, touchCallback: @escaping () -> Void) {
    imageView.kf.setImage(
      with: URL(string: data.image.thumbnailURL),
      options: [.transition(.fade(0.2))]
    )
    
    likesLabel.text = "♥︎ \(data.image.likes)"
    overlayView.isHidden = !data.image.isOverlayOn
    
    /// Bind gesture to cell
    self.rx
      .anyGesture(.longPress())
      .when(.recognized)
      .subscribe { _ in
        touchCallback()
      }
      .disposed(by: disposeBag)
  }
}
