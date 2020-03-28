//
//  ThanosGridView.swift
//  SilentCamera
//
//  Created by kakashi on 3/28/20.
//  Copyright © 2020 BeNguyen. All rights reserved.
//

import Foundation
import UIKit
import Thanos

open class ThanosCollectionCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setupView() { }
}

open class ThanosGridCell<U>: ThanosCollectionCell {
    open func configCell(_ data: U) {
        
    }
}

open class ThanosGridView<C: ThanosGridCell<U>, U>: ThanosView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    open var datasource = [U]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = scrollDirection
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
        collection.showsVerticalScrollIndicator = showsVerticalScrollIndicator
        collection.delegate = self
        collection.dataSource = self
        collection.register(C.self, forCellWithReuseIdentifier: "cellId")
        return collection
    }()
    
    open var columnNumber: Int {
        return 4
    }
    
    open var scrollDirection: UICollectionView.ScrollDirection {
        return .vertical
    }
    
    open var sections: UIEdgeInsets {
        return UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    }
    
    open var showsHorizontalScrollIndicator: Bool {
        return false
    }
    
    open var showsVerticalScrollIndicator: Bool {
        return false
    }
    
    override open func setupView() {
        super.setupView()
        addSubviews(collectionView)
        collectionView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! C
        cell.configCell(datasource[indexPath.row])
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - (CGFloat(columnNumber + 1)*sections.left))/CGFloat(columnNumber)
        return CGSize(width: width, height: width)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sections
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { return sections.left }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sections.left
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { didSelectItem(at: indexPath) }
    
    open func didSelectItem(at indexPath: IndexPath) {}
}
