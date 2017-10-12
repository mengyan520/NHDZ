//
//  UserInfoView.swift
//  NHDZ
//
//  Created by Youcai on 2017/8/4.
//  Copyright © 2017年 mm. All rights reserved.
//

import UIKit

class UserInfoView: UIView {

     // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lazy
    private lazy var iconView: UIImageView = {
        let view = UIImageView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 15
        return view
    }()
    private  lazy var nameLabel: UILabel = {
        let view = UILabel.init(title: "", fontSize: 12, color: BLACK_COLOR, screenInset: 0)
        return view
    }()
   private lazy var sexView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    private lazy var addressBtn: UIButton = {

        let view = UIButton.init(title: "北京", fontSize: 10, color: WHITE_COLOR, imageName: nil, backColor: GRAY_COLOR)
        return view
    }()
    private  lazy var livenNameLabel: UILabel = {
        let view = UILabel.init(title: "", fontSize: 10, color: BLACK_COLOR, screenInset: 0)
        return view
    }()
    private  lazy var integralLabel: UILabel = {
        let view = UILabel.init(title: "", fontSize: 10, color: BLACK_COLOR, screenInset: 0)
        return view
    }()
    private  lazy var fansLabel: UILabel = {
        let view = UILabel.init(title: "", fontSize: 10, color: BLACK_COLOR, screenInset: 0)
        return view
    }()
    private  lazy var followLabel: UILabel = {
        let view = UILabel.init(title: "", fontSize: 10, color: BLACK_COLOR, screenInset: 0)
        return view
    }()
    private lazy var followBtn: UIButton = {
        let view = UIButton.init(title: "加关注", color: RED_COLOR, fontSize: 12, target: self, actionName: nil)
        return view
    }()
}
