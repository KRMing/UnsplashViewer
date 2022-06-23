//
//  ImageCollectionCoordinator.swift
//  UnsplashViewer
//
//  Created by Ming on 2022/06/21.
//

import Foundation
import UIKit

class ImageCollectionCoordinator {
  public func navigateToImageDetailScreen(
    _ currentViewController: UIViewController,
    args: ImageDetailViewControllerArgs
  ) {
    let imageDetailViewController = ImageDetailViewController(
      nibName: "ImageDetailScreen",
      args: args
    )
    currentViewController.navigationController?
      .pushViewController(imageDetailViewController, animated: true)
  }
}
