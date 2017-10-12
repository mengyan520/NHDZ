//
//  HomeVideoTableViewCell.swift
//  NHDZ
//
//  Created by Youcai on 2017/7/28.
//  Copyright © 2017年 mm. All rights reserved.
//

import UIKit
class HomeVideoTableViewCell: HomeTableViewCell {
    // MARK: - Model
    override var viewModel: GroupViewModel? {
        didSet {
            VideoImageView.kf.setImage(with: viewModel?.imgUrls?.first)

            VideoImageView.snp.updateConstraints { (make) -> Void in
                let offset = viewModel?.imgUrls != nil  ? 10 : 0
                make.top.equalTo(typeLabel.snp.bottom).offset(offset)
                make.height.equalTo(viewModel!.height)
            }
            bottomView.snp.remakeConstraints { (make) in
                make.top.equalTo(VideoImageView.snp.bottom).offset(10)
                make.left.equalTo(contentView.snp.left)
                make.width.equalTo(SCREEN_WIDTH)
                make.height.equalTo(30)
            }

        }
    }
    // MARK: - setUI
    override func setUI() {
        super.setUI()
        VideoImageView.addSubview(playBtn)
        playBtn.snp.makeConstraints { (make) in
            make.center.equalTo(VideoImageView)
            make.width.height.equalTo(40)
        }
        VideoImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(typeLabel.snp.bottom).offset(10)
            make.left.equalTo(contentView.snp.left)
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(100)
        }

    }
    // MARK: - click
    func click(sender:UIButton) {
        var tableView = UITableView.init(frame: .zero)
        if (self.superview?.isKind(of: UITableView.self))! {
           tableView = self.superview as! UITableView
        }else if (self.superview?.superview?.isKind(of: UITableView.self))! {
            tableView = self.superview?.superview as! UITableView
            
        }
        //ios 11系统 层次改变
        del?.PlayBtnViewClick(sender: sender, tableView: tableView, pictureView: VideoImageView,url:(viewModel?.Video_url)!)

    }
    // MARK: - Lazy
    private lazy var playBtn: UIButton = {

        let view = UIButton()
        view.backgroundColor = RED_COLOR
        view.addTarget(self, action: #selector(click(sender:)), for: .touchUpInside)
        return view
    }()
}
