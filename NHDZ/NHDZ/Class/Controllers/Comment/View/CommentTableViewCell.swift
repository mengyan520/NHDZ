//
//  CommentTableViewCell.swift
//  NHDZ
//
//  Created by Youcai on 2017/8/3.
//  Copyright © 2017年 mm. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    // MARK: - init
    override init (style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - setUI
    func setUI() {
        backgroundColor = WHITE_COLOR
        contentView.addSubview(iconView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(replyBtn)
        contentView.addSubview(grayView)
        iconView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.left.equalTo(contentView.snp.left).offset(10)
            make.width.height.equalTo(30)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconView.snp.top)
            make.left.equalTo(iconView.snp.right).offset(10)

        }
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.left)
            make.top.equalTo(nameLabel.snp.bottom)


        }
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.left)
            make.top.equalTo(timeLabel.snp.bottom).offset(10)
            make.right.equalTo(contentView.snp.right).offset(-10)
        }
        replyBtn.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.left)
            make.top.equalTo(contentLabel.snp.bottom).offset(10)
            make.right.equalTo(contentView.snp.right).offset(-10)
            make.height.equalTo(20)
        }
        grayView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(replyBtn.snp.bottom).offset(10)
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
    // MARK: - action
    func btnClick(sender:UIButton)  {

    }
    // MARK: - Model
    var viewModel:CommentViewModel? {
        didSet {
            iconView.kf.setImage(with: viewModel?.avatar_url)
            nameLabel.text = viewModel?.name
            timeLabel.text = viewModel?.time
            contentLabel.text = viewModel?.text
            replyBtn.setTitle("查看\(viewModel!.replyCount)回复", for: .normal)
            
            let titleSize = ((replyBtn.titleLabel?.text)! as NSString).size(attributes: [NSFontAttributeName: replyBtn.titleLabel!.font])
            replyBtn.imageEdgeInsets = UIEdgeInsetsMake(0, titleSize.width, 0, -titleSize.width)
            replyBtn.isHidden = viewModel!.replyCount > 0 ? false:true
            replyBtn.snp.updateConstraints { (make) in
                make.height.equalTo(viewModel!.replyCount > 0 ? 15:0)
                make.top.equalTo(contentLabel.snp.bottom).offset(viewModel!.replyCount > 0 ? 10:0)
            }
        }
    }
    // MARK: - rowHeight
    func rowHeight(data: CommentViewModel) -> CGFloat {

        self.viewModel = data
        contentView.layoutIfNeeded()
        return grayView.frame.maxY
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
    private  lazy var timeLabel: UILabel = {
        let view = UILabel.init(title: "", fontSize: 10, color: BLACK_COLOR, screenInset: 20)
        return view
    }()
    private lazy var contentLabel: UILabel = {
        let view = UILabel.init(title: "", fontSize: 14, color: BLACK_COLOR, screenInset: 30)
        return view
    }()
    private lazy var replyBtn: UIButton = {
        let view = UIButton.init(title: "查看7回复", color: BLUE_COLOR, imageName: "gray_arrow", fontSize: 10, target: self, actionName: #selector(btnClick(sender:)))
        view.backgroundColor = WHcolor
        return view
    }()
    private lazy var grayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0.8, alpha: 1.0)
        return view
    }()
}
