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
import RxKingfisher

class ImageCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var view: UIView!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var overlayView: UIView!
  @IBOutlet weak var likesLabel: UILabel!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  private var disposeBag = DisposeBag()
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    /// Initialization code
    setupUI()
  }
  
  override func prepareForReuse() {
    /// Reset expired subscriptions
    disposeBag = DisposeBag()
  }
  
  private func setupUI() {
    view.layer.borderColor = UIColor.black.cgColor
    view.layer.borderWidth = 0
    overlayView.isHidden = true
    activityIndicator.isHidden = false
  }
  
  public func bind(
    to data: ImageCollectionDataSourceType,
    onTap: @escaping () -> Void,
    onLongPress: @escaping () -> Void
  ) {
    imageView.kf.rx.setImage(
      with: URL(string: data.imageCell.image.imageURLs.thumbnail),
      options: [.transition(.fade(0.2))]
    )
    .asCompletable()
    .subscribe(onCompleted: { [weak self] in
      self?.activityIndicator.isHidden = true
    }, onError: { error in
      // TODO: Error handling
    })
    .disposed(by: disposeBag)
    
    likesLabel.text = "♥︎ \(data.imageCell.image.likes)"
    overlayView.isHidden = !data.imageCell.isOverlayOn
    
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
