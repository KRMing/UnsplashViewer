//
//  DI.swift
//  UnsplashViewer
//
//  Created by Ming on 2022/06/16.
//

import Foundation
import Swinject
import SwinjectAutoregistration

class DI {
  public static let injector = DI()
  
  private let container: Container = Container()

  private init() {
    registerDependencies()
  }
  
  public func find<T>() -> T {
    return container.resolve(T.self)!
  }
}

// - MARK: Injector Register Dependencies
extension DI {
  private func registerDependencies() {
    registerCoordinators()
//    registerViewModels()
    registerServices()
    registerRepositories()
  }

  /// Register coordinators
  private func registerCoordinators() {
    /// Register Image Collection Coordinator
    container
      .autoregister(
        ImageCollectionCoordinator.self,
        initializer: ImageCollectionCoordinator.init
      )
      .inObjectScope(.container)
  }

  /// Register view models
//  private func registerViewModels() {
//    /// Register Image Collection View Model
//    container
//      .autoregister(
//        ImageCollectionViewModel.self,
//        initializer: ImageCollectionViewModel.init
//      )
//      .inObjectScope(.container)
//  }

  /// Register services
  private func registerServices() {
    /// Register HTTP Service
    container
      .autoregister(
        HTTPService.self,
        initializer: HTTPService.init
      )
      .inObjectScope(.container)
  }

  /// Register repositories
  private func registerRepositories() {
    /// Register Image Repository
    container
      .autoregister(
        ImageRepository.self,
        initializer: ImageRepository.init
      )
      .inObjectScope(.container)
  }
}

