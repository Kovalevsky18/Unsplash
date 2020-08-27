//
//  CategoryViewController.swift
//  Unsplash
//
//  Created by Родион Ковалевский on 7/13/20.
//  Copyright © 2020 Родион Ковалевский. All rights reserved.
//

import UIKit

private enum Constants {
    static let size = 44
}

protocol CategoryViewControllerOutput: class {
    func viewDidLoad()
    func viewDidRequestNewPage()
}

protocol CategoryViewControllerInput: class {
    func update(viewModel: CategoryViewModel, animated: Bool)
}

final class CategoryViewController: UIViewController {
    
    private var viewModel: CategoryViewModel
    private var navBarTitle = TitleView()
    
    private(set) lazy var collectionView: UICollectionView = { //можем внутри collection изменять , но из экземпляров другого класса можно вызывать
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCellClass(NewCell.self)
        return collectionView
    }()
    
    private(set) lazy var activityView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView()
        activityView.hidesWhenStopped = true
        activityView.color = .white
        activityView.style = .large
        return activityView
    }()
    
    weak var output: CategoryViewControllerOutput? // спросить у димы
    
    init(viewModel: CategoryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
        
        view.addSubview(collectionView)
        view.addSubview(activityView)
        navBarTitle.setTitles(primaryTitle: viewModel.navigationTitle!, secondaryTitle: viewModel.navigationSubtitle!)
        self.navigationItem.titleView = navBarTitle
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        activityView.configureFrame { (maker) in
            maker.center()
            maker.height(Constants.size)
            maker.width(Constants.size)
        }
        collectionView.configureFrame { (maker) in
            maker.edges(insets: .zero)
        }
    }
}

extension CategoryViewController:CategoryViewControllerInput {
    
    func update(viewModel: CategoryViewModel, animated: Bool) {
        let oldViewModel = self.viewModel
        guard viewModel != oldViewModel else {
            return
        }
        self.viewModel = viewModel
        collectionView.reloadData()
        viewModel.isLoading ? activityView.startAnimating() : activityView.stopAnimating()
    }
}

extension CategoryViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let maxVertical = scrollView.contentSize.height - (scrollView.frame.height * 0.3)
        let currentPosition = scrollView.contentOffset.y
        
        let percent = currentPosition/maxVertical * 100
        
        if percent >= 60 {
            output?.viewDidRequestNewPage()
            print(percent)
        }
    }
}

extension CategoryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cellModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellModel = viewModel.cellModels?[safe:indexPath.row] else {
            return UICollectionViewCell()
        }
        
        let cell: NewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.usernameLabel.text = cellModel.userName
        let date = cellModel.date?.stringToDate()?.timeSinceDate(fromDate: Date.dateNow())
        cell.dateLabel.text = date
        let like = String(cellModel.likes ?? 0)
        cell.likeLabel.imageInString(string: like, image: #imageLiteral(resourceName: "like"), imageHeight: 16)
        cell.imageView.nuke_setImage(with: cellModel.imageURL)
        cell.layoutSubviews()
        return cell
    }
    
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cellModel = viewModel.cellModels?[safe: indexPath.row] else {
            return .zero
        }
        let ratio: CGFloat = cellModel.height/cellModel.width //доделать деление на 0 return .zero
        let resultSize: CGSize = .init(width: collectionView.bounds.width, height:collectionView.bounds.width * ratio)
        return resultSize
    }
}
