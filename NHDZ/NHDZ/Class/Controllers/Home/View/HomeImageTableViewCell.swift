//
//  HomeImageTableViewCell.swift
//  NHDZ
//
//  Created by Youcai on 2017/7/27.
//  Copyright © 2017年 mm. All rights reserved.
//

import UIKit

class HomeImageTableViewCell: HomeTableViewCell {
    // MARK: - Model
    override var viewModel: GroupViewModel? {
        didSet {

            pictureView.viewModel = viewModel

            pictureView.snp.updateConstraints { (make) -> Void in
                let offset = viewModel?.imgUrls != nil  ? 10 : 0
                make.top.equalTo(typeLabel.snp.bottom).offset(offset)
                make.height.equalTo(pictureView.bounds.height)
                make.width.equalTo(pictureView.bounds.width)
               make.left.equalTo(contentView.snp.left).offset(viewModel?.imgUrls?.count == 1 ?0:10)


            }


        }
    }
    // MARK: - setUI
    override func setUI() {
        super.setUI()
        contentView.addSubview(pictureView)
        pictureView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(typeLabel.snp.bottom).offset(10)
            make.left.equalTo(contentView.snp.left).offset(10)
            make.width.equalTo(SCREEN_WIDTH-20)
            make.height.equalTo(100)
        }
        bottomView.snp.remakeConstraints { (make) in
            make.top.equalTo(pictureView.snp.bottom).offset(10)
            make.left.equalTo(contentView.snp.left)
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(30)
        }
    }
    private lazy var pictureView: HomePictureView = HomePictureView()
}
