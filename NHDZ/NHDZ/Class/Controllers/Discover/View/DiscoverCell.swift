//
//  DiscoverCell.swift
//  NHDZ
//
//  Created by Youcai on 2017/7/26.
//  Copyright © 2017年 mm. All rights reserved.
//

import UIKit

class DiscoverCell: UITableViewCell {
    // MARK: - init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        backgroundColor = WHITE_COLOR
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - setUI
    func setUI() {
        contentView.addSubview(iconView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(desLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(subscribeButton)
        iconView.snp.makeConstraints { (make) in
            make.top.left.equalTo(contentView).offset(10)
            make.width.height.equalTo(43)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.left.equalTo(iconView.snp.right).offset(10)

        }
        desLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.equalTo(titleLabel.snp.left)
            make.width.equalTo(SCREEN_WIDTH-40-43-100)
        }
        countLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(iconView.snp.bottom)
            make.left.equalTo(titleLabel.snp.left)

        }
        subscribeButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView.snp.centerY)
            make.right.equalTo(contentView.snp.right).offset(-10)
            make.width.equalTo(43)
            make.height.equalTo(21)
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
    var data: Category_list? {
        didSet {
            iconView.kf.setImage(with: URL.init(string: (data?.icon_url)!))
            titleLabel.text = data?.name
            desLabel.text = data?.placeholder

            countLabel.text = "\(data!.subscribe_count) 订阅 | 总帖数 \(data!.total_updates)"
        }
    }
    // MARK: - Lazy
    private lazy var iconView: UIImageView = {
        let view = UIImageView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    private lazy var titleLabel: UILabel = {
        let view = UILabel.init(title: "", fontSize: 12, color: BLACK_COLOR, screenInset: 20)
        view.backgroundColor = WHITE_COLOR
        view.layer.masksToBounds = true
        return view
    }()
    private lazy var desLabel: UILabel = {
        let view = UILabel.init(title: "", fontSize: 10, color:GRAY_COLOR, screenInset: 20)
        view.backgroundColor = WHITE_COLOR
        view.layer.masksToBounds = true
        return view
    }()
    private lazy var countLabel: UILabel = {
        let view = UILabel.init(title: "", fontSize: 10, color:GRAY_COLOR, screenInset: 20)
        view.backgroundColor = WHITE_COLOR
        view.layer.masksToBounds = true
        return view
    }()
    private lazy var subscribeButton: UIButton = {
        let view: UIButton = UIButton.init(title: "订阅", color: GRAY_COLOR, fontSize: 12, target: self, actionName: nil)
        view.layer.borderColor = GRAY_COLOR.cgColor
        view.layer.borderWidth = 0.5
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 2
        view.backgroundColor = WHITE_COLOR
        return view
    }()
}
