//
//  ImageDetailViewController.swift
//  UnsplashViewer
//
//  Created by Ming on 2022/06/22.
//

import UIKit
import RxSwift

struct ImageDetailViewControllerArgs {
  
}

class ImageDetailViewController: UIViewController {
  @IBOutlet weak var imageView: UIImageView!
  
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
    
    imageView.kf.setImage(
      with: URL(string: ),
      options: [.transition(.fade(0.2))]
    )
  }
}
