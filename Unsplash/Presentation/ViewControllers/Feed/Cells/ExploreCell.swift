//
//  ExploreCell.swift
//  Unsplash
//
//  Created by Родион Ковалевский on 7/8/20.
//  Copyright © 2020 Родион Ковалевский. All rights reserved.
//

import UIKit

final class ExploreCell: UICollectionViewCell {
    
    private(set) lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 14
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collectionView.backgroundColor = .black
        collectionView.registerCellClass(CustomExploreCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    var cellModelResolver: (()-> [FeedExploreCellModel])?
    var cellSelectionHandler: ((IndexPath)-> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(collectionView)
        contentView.backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.configureFrame { (maker) in
            maker.edges(insets: .zero)
        }
    }
    
    func update() {
        collectionView.reloadData()
    }
}

extension ExploreCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellModelResolver?().count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellModel = cellModelResolver?()[safe:indexPath.row] else {
            return UICollectionViewCell()
        }
        let cell: CustomExploreCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.titleLabel.text = cellModel.title
        cell.layoutSubviews()
        cell.imageView.nuke_setImage(with: cellModel.imageURL)
        return cell
    }
}

extension ExploreCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellSelectionHandler?(indexPath)
    }
}

extension ExploreCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}

