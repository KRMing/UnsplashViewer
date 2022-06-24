//
//  ImageCollectionCoordinator.swift
//  UnsplashViewer
//
//  Created by Ming on 2022/06/21.
//

import Foundation
import UIKit

class ImageCollectionCoordinator {
  public func navigateToImageDetailView(
    _ currentViewController: UIViewController,
    args: ImageDetailViewArgs
  ) {
    let imageDetailViewController = ImageDetailViewController(
      nibName: "ImageDetailView",
      args: args
    )
    currentViewController.navigationController?
      .pushViewController(imageDetailViewController, animated: true)
  }
}
