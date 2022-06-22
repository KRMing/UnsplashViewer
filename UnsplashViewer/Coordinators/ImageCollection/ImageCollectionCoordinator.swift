//
//  ImageCollectionCoordinator.swift
//  UnsplashViewer
//
//  Created by Ming on 2022/06/21.
//

import Foundation
import UIKit

class ImageCollectionCoordinator {
  public func navigateToImageDetailScreen(currentViewController: UIViewController) {
    let imageDetailViewController = ImageDetailViewController(
      nibName: "ImageDetailScreen",
      bundle: nil
    )
    currentViewController.navigationController?
      .pushViewController(imageDetailViewController, animated: true)
  }
}
