//
//  ViewController.swift
//  Unsplash
//
//  Created by Родион Ковалевский on 7/8/20.
//  Copyright © 2020 Родион Ковалевский. All rights reserved.
//

import UIKit

protocol FeedViewControllerOutput: class {
    func viewDidLoad()
    func viewDidSelect(category with: IndexPath)
    func viewDidRequestNewPage()
    func loginButtonDidSelect()
}

protocol FeedViewControllerInput: class {
    func update(viewModel: FeedViewModel, animated: Bool)
}

final class FeedViewController: UIViewController {
    
    private enum Constants {
        static let size = 44
    }
    
    private(set) lazy var collectionView: UICollectionView = { //можем внутри collection изменять , но из экземпляров другого класса можно вызывать
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerHeaderViewClass(FeedSectionView.self)
        collectionView.registerCellClass(ExploreCell.self)
        collectionView.registerCellClass(NewCell.self)
        return collectionView
    }()
    
    private(set) lazy var activityView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView()
        activityView.style = .large
        activityView.hidesWhenStopped = true
        activityView.color = .white
        activityView.isHidden = false
        return activityView
    }()
    
    static let sizingHeader: FeedSectionView = .init()
    private var viewModel: FeedViewModel
    private var itemCount = 0
    
    weak var output: FeedViewControllerOutput?
    
    init(viewModel: FeedViewModel) {
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Asset.account.image, style: .plain, target: self, action: #selector(handleLoginButton))
        
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
    
    @objc private func handleLoginButton() {
        output?.loginButtonDidSelect()
    }
}

extension FeedViewController: FeedViewControllerInput {
    
    func update(viewModel: FeedViewModel, animated: Bool) {
        let oldViewModel = self.viewModel
        guard viewModel != oldViewModel else {
            return
        }
        
        self.viewModel = viewModel
        collectionView.reloadData()
        viewModel.isLoading ? activityView.startAnimating() :
            activityView.stopAnimating()
    }
}

extension FeedViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let maxVertical = scrollView.contentSize.height - (scrollView.frame.height * 0.3)
        let currentPosition = scrollView.contentOffset.y
        
        let percent = currentPosition/maxVertical * 100
        
        if percent >= 10 {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
        else {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
        
        if percent >= 60 {
            output?.viewDidRequestNewPage()
        }
    }
}

extension FeedViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.feedSectionModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let sectionModel = viewModel.feedSectionModels[safe: indexPath.section] else {
            return UICollectionReusableView()
        }
        
        let sectionView: FeedSectionView = collectionView.dequeueReusableHeaderView(for: indexPath)
        sectionView.backgroundColor = .white
        sectionView.titleLabel.text = sectionModel.title
        sectionView.layoutSubviews()
        return sectionView
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0  {
            return 1
        }
        itemCount = viewModel.feedSectionModels[safe: section]?.cellModels?.count ?? 0
        return viewModel.feedSectionModels[safe: section]?.cellModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell: ExploreCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.cellModelResolver = { [weak self] in
                return self?.viewModel.feedSectionModels[safe:indexPath.section]?.cellModels as? [FeedExploreCellModel] ?? []
            }
            cell.cellSelectionHandler = { [weak self] internalIndex in
                self?.output?.viewDidSelect(category: internalIndex)
            }
            cell.layoutSubviews()
            cell.update()
            return cell
        }
        guard let cellModel = viewModel.feedSectionModels[safe:indexPath.section]?.cellModels?[safe:indexPath.row] as? FeedNewCellModel else {
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

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard let sectionModel = viewModel.feedSectionModels[safe: section]  else {
            return .zero
        }
        
        type(of: self).sizingHeader.titleLabel.text = sectionModel.title
        return type(of: self).sizingHeader.sizeThatFits(collectionView.bounds.size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height * 0.3)
        }
        guard let cellModel = viewModel.feedSectionModels[safe: indexPath.section]?.cellModels?[safe: indexPath.row] as? FeedNewCellModel else {
            return .zero
        }
        let ratio: CGFloat = cellModel.height/cellModel.width //доделать деление на 0 return .zero
        let resultSize: CGSize = .init(width: collectionView.bounds.width, height:collectionView.bounds.width * ratio)
        return resultSize
    }
}



