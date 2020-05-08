//
//  ThanosGridCtr.swift
//  SilentCamera
//
//  Created by kakashi on 3/28/20.
//  Copyright © 2020 BeNguyen. All rights reserved.
//

import Foundation
import UIKit

open class ThanosGridCtr<C: ThanosGridCell<U>, U>: ThanosCtr, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    open var datasource = [U]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    open lazy var collectionView: UICollectionView = {
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
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(collectionView)
        collectionView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! C
        cell.configCell(datasource[indexPath.row])
        return cell
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - (CGFloat(columnNumber + 1)*sections.left))/CGFloat(columnNumber)
        return CGSize(width: width, height: width)
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sections
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { return sections.left }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sections.left
    }
    
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { didSelectItem(at: indexPath) }
    
    open func didSelectItem(at indexPath: IndexPath) {}
}
