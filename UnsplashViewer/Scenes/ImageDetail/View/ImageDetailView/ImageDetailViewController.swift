//
//  ImageDetailViewController.swift
//  UnsplashViewer
//
//  Created by Ming on 2022/06/22.
//

import UIKit
import RxSwift
import RxKingfisher

class ImageDetailViewController: UIViewController {
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var artistLabel: UILabel!
  @IBOutlet weak var activityIndicatorView: UIView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  private let viewModel: ImageDetailViewModel
  private var disposeBag = DisposeBag()
  
  init(nibName: String, args: ImageDetailViewArgs) {
    /// Custom initialization
    self.viewModel = ImageDetailViewModel(args: args)
    
    super.init(nibName: nibName, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError(AppConstants.coderInitErrorMessage)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    
    bind()
  }
  
  private func setupUI() {
    func setupDescriptionLabel() {
      let noDescription = viewModel.image.description == nil
      descriptionLabel.text = viewModel.image.description ?? "No Description"
      if noDescription {
        descriptionLabel.textColor = .gray.withAlphaComponent(0.2)
      }
      descriptionLabel.sizeToFit()
      descriptionLabel.lineBreakMode = .byWordWrapping
    }
    
    func setupArtistLabel() {
      let username = viewModel.image.user.username
      let name = viewModel.image.user.name
      artistLabel.text = "@\(username) | \(name)"
    }
    
    setupDescriptionLabel()
    setupArtistLabel()
  }
  
  private func bind() {
    imageView.kf.rx.setImage(
      with: URL(string: viewModel.image.imageURLs.regular)
    )
    .asDriver(onErrorJustReturn: UIImage())
    .drive(onNext: { [weak self] image in
      guard let self = self else { return }
      let ratio = image.size.height / image.size.width
      let newHeight = self.imageView.frame.width * ratio
      self.imageViewHeight.constant = newHeight
      self.imageView.contentMode = .scaleAspectFill
    
      UIView.animate(withDuration: 0.5, animations: {
        self.view.layoutIfNeeded()
      }) { _ in
        self.activityIndicatorView.isHidden = true
      }
    })
    .disposed(by: disposeBag)
  }
}
