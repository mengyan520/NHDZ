//
//  HomePictureView.swift
//  NHDZ
//
//  Created by Youcai on 2017/7/27.
//  Copyright © 2017年 mm. All rights reserved.
//

import UIKit
private let cellID = "cellID"
class HomePictureView: UICollectionView {

    // MARK: - init
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        super.init(frame: .zero, collectionViewLayout: layout)
        backgroundColor = WHITE_COLOR
        dataSource = self
        delegate = self
        register(PictureViewCell.self, forCellWithReuseIdentifier: cellID)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Model
    var viewModel: GroupViewModel? {
        didSet {

            sizeToFit()
            reloadData()
        }
    }
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return calcViewSize()
    }
}
// MARK: - UICollectionViewDataSource/UICollectionViewDelegate
extension HomePictureView:UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.imgUrls?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! PictureViewCell
        cell.url = viewModel?.imgUrls?[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("d")
    }
}
// MARK: - 计算视图大小
extension HomePictureView {

    /// 计算视图大小
    fileprivate func calcViewSize() -> CGSize {

        // 1. 准备
        // 每行的照片数量
        let rowCount: CGFloat = 3
        // 最大宽度
        let maxWidth = UIScreen.main.bounds.width - 2 *  10
        let itemWidth = (maxWidth - 2 *  5) / rowCount

        // 2. 设置 layout 的 itemSize
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)

        // 3. 获取图片数量
        let count =  viewModel?.imgUrls?.count ?? 0

        // 计算开始
        // 1> 没有图片
        if count == 0 {
            return .zero
        }

        // 2> 一张图片
        if count == 1 {
            //CGSize.init(width: (viewModel?.width)!, height: (viewModel?.height)!)//

            let size = CGSize.init(width: SCREEN_WIDTH, height: (viewModel?.height)!)//CGSize(width: SCREEN_WIDTH, height:  200)

            // 内部图片的大小
            layout.itemSize = size

            // 配图视图的大小
            return size
        }

        // 3> 四张图片 2 * 2 的大小
        if count == 4 {
            let w = 2 * itemWidth +  5

            return CGSize(width: w, height: w)
        }
        // 4> 其他图片 按照九宫格来显示
        // 计算出行数
        /**
         2 3
         5 6
         7 8 9
         */
        let row = CGFloat((count - 1) / Int(rowCount) + 1)
        let h = row * itemWidth + (row - 1) *  5 + 1
        let w = rowCount * itemWidth + (rowCount - 1) *  5 + 1

        return CGSize(width: w, height: h)
    }

}
// MARK: - 配图 cell
private class PictureViewCell: UICollectionViewCell {

    var url: URL? {
        didSet {

           iconView.kf.setImage(with: url!)
        }
    }

    // MARK: - 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
          setUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

     func setUI() {
       contentView.addSubview(iconView)
        iconView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(contentView.snp.edges)
        }

    }
    // MARK: - Lazy
    private lazy var iconView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        //view.isUserInteractionEnabled = true
        return view
    }()

}
