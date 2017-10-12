//
//  HomeBottomView.swift
//  NHDZ
//
//  Created by Youcai on 2017/8/1.
//  Copyright © 2017年 mm. All rights reserved.
//

import UIKit

class HomeBottomView: UIView {

    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     // MARK: - setUI
    func setUI() {
        backgroundColor = WHITE_COLOR
        addSubview(likeBtn)
        addSubview(dontLikeBtn)
        addSubview(commentBtn)
        addSubview(shareBtn)
        likeBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self.snp.left).offset(10)
            make.height.equalTo(20)
            make.width.equalTo(100)
        }
        dontLikeBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(likeBtn.snp.right).offset(10)
            make.height.equalTo(20)
            make.width.equalTo(100)
        }
        commentBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(dontLikeBtn.snp.right).offset(10)
            make.height.equalTo(20)
            make.width.equalTo(100)
        }
        shareBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(self.snp.right).offset(-10)
            make.height.equalTo(20)
            make.width.equalTo(100)
        }
    }
     // MARK: - click
    func btnClick(sender:UIButton) {

    }
    // MARK: - Lazy
    //点赞
    private lazy var likeBtn:UIButton = {
        let btn = UIButton()
        btn.tag = 1
        return btn
    }()
    //踩
    private lazy var dontLikeBtn:UIButton = {
        let btn = UIButton()
        btn.tag = 2
        return btn
    }()
    //评论
    private lazy var commentBtn:UIButton = {
        let btn = UIButton()
        btn.tag = 3
        return btn
    }()
    //分享
    private lazy var shareBtn:UIButton = {
        let btn = UIButton()
        btn.tag = 4
        return btn
    }()
}
