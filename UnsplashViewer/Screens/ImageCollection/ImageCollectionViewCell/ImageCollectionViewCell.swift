//
//  ImageCollectionViewCell.swift
//  UnsplashViewer
//
//  Created by Ming on 2022/06/17.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
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
  
  public func bind(
    to data: ImageCollectionDataSourceType,
    onTap: @escaping () -> Void,
    onLongPress: @escaping () -> Void
  ) {
    imageView.kf.setImage(
      with: URL(string: data.image.thumbnailURL),
      options: [.transition(.fade(0.2))]
    )
    
    likesLabel.text = "♥︎ \(data.image.likes)"
    overlayView.isHidden = !data.image.isOverlayOn
    
    /// Bind gestures to cell
    self.rx
      .anyGesture(.tap(configuration: { gestureRecognizer, delegate in
        delegate.simultaneousRecognitionPolicy = .never
      }))
      .when(.recognized)
      .subscribe { _ in
        onTap()
      }
      .disposed(by: disposeBag)

    self.rx
      .anyGesture(.longPress(configuration: { gestureRecognizer, delegate in
        gestureRecognizer.minimumPressDuration = 0.2
        delegate.simultaneousRecognitionPolicy = .never
      }))
      .when(.began)
      .subscribe { _ in
        onLongPress()
      }
      .disposed(by: disposeBag)
  }
}
