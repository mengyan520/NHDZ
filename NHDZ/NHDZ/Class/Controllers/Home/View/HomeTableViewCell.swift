//
//  HomeTableViewCell.swift
//  NHDZ
//
//  Created by Youcai on 2017/7/27.
//  Copyright © 2017年 mm. All rights reserved.
//

import UIKit
protocol HomeCellDel:NSObjectProtocol {

    func PlayBtnViewClick(sender:UIButton,tableView:UITableView,pictureView:UIImageView,url:URL)
}
class HomeTableViewCell: UITableViewCell {
    // MARK: - init
    override init (style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        //selectionStyle = .none
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - setUI
    func setUI() {
        backgroundColor = WHITE_COLOR
        contentView.addSubview(iconView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(typeLabel)
       
        contentView.addSubview(VideoImageView)
        contentView.addSubview(bottomView)
        contentView.addSubview(grayView)
        iconView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.left.equalTo(contentView.snp.left).offset(10)
            make.width.height.equalTo(30)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(iconView.snp.centerY)
            make.left.equalTo(iconView.snp.right).offset(10)

        }
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(10)
            make.top.equalTo(iconView.snp.bottom).offset(10)
            //make.right.equalTo(contentView.snp.right).offset(-10)
            make.width.equalTo(SCREEN_WIDTH-20)
        }
        typeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(10)
            make.top.equalTo(contentLabel.snp.bottom).offset(10)

        }
        bottomView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(typeLabel.snp.bottom).offset(10)
            make.left.equalTo(contentView.snp.left)
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(30)
        }
        grayView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(bottomView.snp.bottom).offset(10)
            make.left.equalTo(contentView.snp.left)
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(2)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    // MARK: - Model
    var viewModel: GroupViewModel? {
        didSet {

            iconView.kf.setImage(with: viewModel?.avatar_url)
            nameLabel.text = viewModel?.name
            contentLabel.text = viewModel?.text
            typeLabel.text = viewModel?.category_name
          }
    }
    // MARK: - rowHeight
    func rowHeight(data: GroupViewModel) -> CGFloat {

        self.viewModel = data
        contentView.layoutIfNeeded()
        return grayView.frame.maxY
    }
    // MARK: - Lazy
    weak var del:HomeCellDel?
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
    lazy var typeLabel: UILabel = {
        let view = UILabel.init(title: "", fontSize: 12, color: BLACK_COLOR, screenInset: 0)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 4
        return view
    }()
    lazy var contentLabel: UILabel = {
        let view = UILabel.init(title: "", fontSize: 14, color: BLACK_COLOR, screenInset: 10)
        return view
    }()
    
    lazy var VideoImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.isUserInteractionEnabled = true
        return view
    }()
    lazy var bottomView: HomeBottomView = {
        let view = HomeBottomView.init(frame: .zero)

        return view
    }()
    lazy var grayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0.95, alpha: 1.0)
        return view
    }()
}
