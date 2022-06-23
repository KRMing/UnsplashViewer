//
//  ImageDetailViewController.swift
//  UnsplashViewer
//
//  Created by Ming on 2022/06/22.
//

import UIKit
import RxSwift
import RxKingfisher

struct ImageDetailViewControllerArgs {
  let image: Image
}

class ImageDetailViewController: UIViewController {
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
  
  private let viewModel: ImageCollectionViewModel = DI.injector.find()
  private let coordinator: ImageCollectionCoordinator = DI.injector.find()
  private var disposeBag = DisposeBag()
  private let args: ImageDetailViewControllerArgs
  
  init(nibName: String, args: ImageDetailViewControllerArgs) {
    /// Custom initialization
    self.args = args
    
    super.init(nibName: nibName, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError(AppConstants.coderInitErrorMessage)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    bind()
  }
  
  private func bind() {
    imageView.kf.rx.setImage(
      with: URL(string: args.image.imageURLs.full),
      options: [.transition(.fade(0.2))]
    )
    .asDriver(onErrorJustReturn: UIImage())
    .drive(onNext: { [weak self] image in
      guard let self = self else { return }
      let ratio = image.size.height / image.size.width
      let newHeight = self.imageView.frame.width * ratio
      self.imageViewHeight.constant = newHeight
      self.imageView.contentMode = .scaleAspectFill
      self.view.layoutIfNeeded()
    })
    .disposed(by: disposeBag)
  }
}
