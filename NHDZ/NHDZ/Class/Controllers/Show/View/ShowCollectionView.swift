//
//  ShowCollectionView.swift
//  NHDZ
//
//  Created by Youcai on 2017/8/1.
//  Copyright © 2017年 mm. All rights reserved.
//

import UIKit
private let cellID = "cellID"
class ShowCollectionView: UICollectionView {

    // MARK: - init
    init(frame: CGRect) {
        let layout = ShowCollectionViewLayout()
        //layout.minimumInteritemSpacing = 5
        //layout.minimumLineSpacing = 5
        //layout.itemSize = CGSize.init(width: (SCREEN_WIDTH-5)/2.0, height:300)
        super.init(frame: frame, collectionViewLayout: layout)
        backgroundColor = WHITE_COLOR
        dataSource = self
        delegate = self
        register(ShowCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Model
    var dataArrays: [GroupViewModel]? {
        didSet {


            reloadData()
        }
    }
}
// MARK: - UICollectionViewDataSource/UICollectionViewDelegate
extension ShowCollectionView:UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArrays?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ShowCollectionViewCell
        cell.viewModel = dataArrays?[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(dataArrays?[indexPath.row].data)
    }
}
