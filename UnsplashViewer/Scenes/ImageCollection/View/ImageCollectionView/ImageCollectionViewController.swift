//
//  ImageCollectionViewController.swift
//  UnsplashViewer
//
//  Created by Ming on 2022/06/16.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import RxGesture

class ImageCollectionViewController: UIViewController {
  @IBOutlet weak var collectionView: UICollectionView!
  
  private let viewModel: ImageCollectionViewModel
  private let coordinator: ImageCollectionCoordinator = DI.injector.find()
  private var disposeBag = DisposeBag()
  
  init(nibName: String, args: ImageCollectionViewArgs) {
    /// Custom initialization
    self.viewModel = ImageCollectionViewModel(args: args)
    
    super.init(nibName: nibName, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError(AppConstants.coderInitErrorMessage)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    /// CollectionView Initialization
    setupCollectionView()
    setupDataSource()
    
    /// UI Initialization
    setupUI()
    
    /// Bind Data
    bind()
    
    /// Get Data from API
    viewModel.getImages()
  }
  
  private func setupUI() {
    func setupNavigationBar() {
      if #available(iOS 13.0, *) {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
      } else {
        edgesForExtendedLayout = []
      }
      
      navigationItem.title = "Unsplash Viewer"
    }
    
    func setupCollectionViewFlowLayout() {
      let screenWidth = UIScreen.main.bounds.size.width
      let collectionViewWidth = collectionView.bounds.size.width
      let width = (screenWidth > collectionViewWidth) ? screenWidth : collectionViewWidth
      let cellSize = width / CGFloat(3)
      let layout = UICollectionViewFlowLayout()
      layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
      layout.itemSize = CGSize(width: cellSize, height: cellSize)
      layout.minimumInteritemSpacing = 0
      layout.minimumLineSpacing = 0
      collectionView.collectionViewLayout = layout
    }
    
    func setupNavigationBarTestButton() {
      navigationItem.rightBarButtonItem = UIBarButtonItem(
        title: "TEST",
        style: .plain,
        target: self,
        action: #selector(onTestButtonTap)
      )
    }
    
    setupNavigationBar()
    setupCollectionViewFlowLayout()
    setupNavigationBarTestButton()
  }
  
  @objc private func onTestButtonTap() {
    viewModel.getImages(resetImages: true)
  }
  
  private func bind() {
    viewModel.imageCellsDriver
      .map {
        [ImageCollectionSectionDataSourceType(
          identity: "0",
          items: $0.map {
            ImageCollectionDataSourceType(identity: $0.image.id, imageCell: $0)
          }
        )]
      }
      .drive(collectionView.rx.items(dataSource: viewModel.dataSource!))
      .disposed(by: disposeBag)
    
    collectionView.rx.willDisplayCell
      .filter { $0.cell.isKind(of: ImageCollectionViewCell.self) }
      .map { ($0.cell as! ImageCollectionViewCell, $0.at.item) }
      .subscribe { [weak self] cell, index in
        guard let self = self else { return }
        if index == self.viewModel.loadNextPageThreshold {
          self.viewModel.getImages()
        }
      }
      .disposed(by: disposeBag)
  }
}

extension ImageCollectionViewController: UICollectionViewDelegate {
  // - MARK: Collection View Initialization
  private func setupCollectionView() {
    collectionView.rx.setDelegate(self)
      .disposed(by: disposeBag)
    collectionView.register(
      UINib(
        nibName: String(describing: ImageCollectionViewCell.self),
        bundle: nil
      ),
      forCellWithReuseIdentifier: String(describing: ImageCollectionViewCell.self)
    )
  }
  
  private func setupDataSource() {
    viewModel.dataSource = ImageCollectionViewDataSource {
      dataSource, collectionView, indexPath, data -> UICollectionViewCell in
      let defaultCell = UICollectionViewCell()
      guard
        let cell = collectionView.dequeueReusableCell(
          withReuseIdentifier: String(describing: ImageCollectionViewCell.self),
          for: indexPath
        ) as? ImageCollectionViewCell
      else { return defaultCell }
      
      cell.bind(
        to: data,
        onTap: { [weak self] in
          guard let self = self else { return }
          self.coordinator.navigateToImageDetailView(
            self,
            args: ImageDetailViewArgs(
              image: data.imageCell.image
            )
          )
        },
        onLongPress: { [weak self] in
          self?.viewModel.setOverlayOn(for: data.imageCell.image.id)
        }
      )
      
      return cell
    }
    
    viewModel.dataSource!.animationConfiguration = AnimationConfiguration(
      insertAnimation: .fade,
      reloadAnimation: .none,
      deleteAnimation: .fade
    )
  }
}
