//
//  CollectionViewLayout.swift
//  NHDZ
//
//  Created by Youcai on 2017/8/2.
//  Copyright © 2017年 mm. All rights reserved.
//

import UIKit

class ShowCollectionViewLayout: UICollectionViewLayout {
    // 存放所有cell的布局属性
    private lazy var cellArray = [UICollectionViewLayoutAttributes]()
    // 每一列的最大y坐标
    private lazy var columnMaxYArray = [CGFloat]()
    // 默认行间距
    var defaultRowSpacing:CGFloat = 10
    // 默认列间距
    var defaultColumnSpacing:CGFloat = 10
    // 默认边距
    var defaultEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
    // 默认列数
    var defaultColumnCount:CGFloat = 2
    // MARK: - prepare
    override func prepare() {
        super.prepare()
        // 重置每一列的最大y坐标
        columnMaxYArray.removeAll()
        for i in 0..<Int(defaultColumnCount) {
            columnMaxYArray.insert(0, at: i)
        }
        // 计算所有cell的布局属性
        cellArray.removeAll()
        let count = collectionView?.numberOfItems(inSection: 0)
        for i in 0..<count! {
            let indexPath = IndexPath.init(item: i, section: 0)
            let attrs = layoutAttributesForItem(at: indexPath)
            cellArray.insert(attrs!, at: i)
        }
    }
    // MARK: - ContentSize
    //CollectionView的大小
    override var collectionViewContentSize: CGSize {

        return CGSize.init(width: (collectionView?.frame.size.width)!, height: columnMaxYArray.max()! + defaultEdgeInsets.bottom)
    }
    // MARK: - UICollectionViewLayoutAttributes
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        //        let array = [UICollectionViewLayoutAttributes]()
        //        for i in 0..<cellArray.count {
        //
        //        }
        return cellArray
    }
    // MARK: - indexPath
    //该方法为每个Cell绑定一个Layout属性~
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
        // 计算indexPath位置cell的布局属性
        // 找出最短那一列的列号和最大y坐标
        var  columnMaxY = columnMaxYArray.first
        var  columnIndex:CGFloat = 0
        for i in 0..<columnMaxYArray.count {
            let y = columnMaxYArray[i]
            if y < columnMaxY! {
                columnMaxY = y
                columnIndex = CGFloat(i)
            }
        }
        let totalColumnSpacing = (defaultColumnCount-1) * defaultColumnSpacing
        let width = ((collectionView?.frame.size.width)! - defaultEdgeInsets.left - defaultEdgeInsets.right - totalColumnSpacing) / defaultColumnCount
        let height:CGFloat = CGFloat(50 + arc4random_uniform(150))
        let x = defaultEdgeInsets.left + columnIndex * (width + defaultColumnSpacing)
        let y  = columnMaxY! + defaultColumnSpacing
       attributes.frame = CGRect.init(x: x, y: y, width: width, height: height)
        // 更新最大y坐标
   
        columnMaxYArray[Int(columnIndex)] = attributes.frame.maxY
        return attributes
    }


}
