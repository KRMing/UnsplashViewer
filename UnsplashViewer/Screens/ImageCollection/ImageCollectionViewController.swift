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

class ImageCollectionViewController: UIViewController {
  @IBOutlet weak var collectionView: UICollectionView!
  
  let viewModel: ImageCollectionViewModel = DI.injector.find()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    /// ViewController Initialization
    setupCollectionView()
    setupDataSource()
    
    /// UI Initialization
    setupUI()
    
    /// Bind Data
    bind()
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
    
    setupNavigationBar()
    setupCollectionViewFlowLayout()
  }
  
  private func bind() {
    viewModel.dataFromApi
      .map {
        [ImageCollectionSection(
          identity: "0",
          items: $0.map {
            ImageCollection(identity: String($0.value), image: $0)
          }
        )]
      }
      .drive(collectionView.rx.items(dataSource: viewModel.dataSource!))
      .disposed(by: viewModel.disposeBag)
  }
}

extension ImageCollectionViewController: UICollectionViewDelegate {
  // - MARK: Collection View Initialization
  private func setupCollectionView() {
    collectionView.rx.setDelegate(self)
      .disposed(by: viewModel.disposeBag)
    collectionView.register(
      UINib(nibName: ImageCollectionViewCell.className, bundle: nil),
      forCellWithReuseIdentifier: ImageCollectionViewCell.className
    )
  }
  
  private func setupDataSource() {
    viewModel.dataSource = ImageCollectionDataSource {
      dataSource, collectionView, indexPath, model -> UICollectionViewCell in
      let defaultCell = UICollectionViewCell()
      guard
        let cell = collectionView.dequeueReusableCell(
          withReuseIdentifier: String(describing: ImageCollectionViewCell.self),
          for: indexPath
        ) as? ImageCollectionViewCell
      else { return defaultCell }
      
      cell.bind(to: model)
      
      return cell
    }
    
    viewModel.dataSource!.animationConfiguration = AnimationConfiguration(
      insertAnimation: .fade,
      reloadAnimation: .none,
      deleteAnimation: .fade
    )
  }
}
