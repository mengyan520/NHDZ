//
//  CategoryHeaderView.swift
//  NHDZ
//
//  Created by Youcai on 2017/7/27.
//  Copyright © 2017年 mm. All rights reserved.
//

import UIKit
class CategoryHeaderView: UIView {
    var scrollView: UIScrollView?
    // MARK: - init
    init(frame: CGRect, scrollView: UIScrollView) {

        super.init(frame: frame)
        backgroundColor = WHITE_COLOR
        self.scrollView = scrollView
        scrollView .addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
        setUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - setUI
    func setUI() {
        addSubview(backView)
        addSubview(iconView)
        addSubview(subscribeButton)
        addSubview(countLabel)
        addSubview(desLabel)
        backView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.snp.edges)
        }

        desLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.snp.bottom).offset(-15)
            make.left.equalTo(self.snp.left).offset(10)
            make.width.equalTo(SCREEN_WIDTH-20)
        }
        iconView.snp.makeConstraints { (make) in
            make.bottom.equalTo(desLabel.snp.top).offset(-5)
            make.left.equalTo(self.snp.left).offset(10)
            make.width.height.equalTo(43)
        }
        subscribeButton.snp.makeConstraints { (make) in
            make.top.equalTo(iconView.snp.top)
            make.left.equalTo(iconView.snp.right).offset(10)
            make.width.equalTo(43)
            make.height.equalTo(21)
        }
        countLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(iconView.snp.bottom)
            make.left.equalTo(subscribeButton.snp.left)

        }

    }
    // MARK: - kvo
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {

        let offsetY = -((change![NSKeyValueChangeKey.newKey]! as AnyObject).cgPointValue.y)

        if  offsetY < 1 {
            return
        }
        self.height = offsetY > 64 ? offsetY : 64
        let alpha = (self.height-70)/70
        iconView.alpha = alpha
        subscribeButton.alpha = alpha
        countLabel.alpha = alpha
        desLabel.alpha = alpha
    }
    // MARK: - Click
    func  btnClick(sender: UIButton) {

    }
    // MARK: - Model
    var data: Category_info? {
        didSet {
            backView.kf.setImage(with: URL.init(string: (data?.icon_url)!), placeholder: nil, options: nil, progressBlock: nil) { (image, _, _, _) in
                self.backView.image = image?.applyDarkEffect()
            }
            iconView.kf.setImage(with: URL.init(string: (data?.small_icon_url)!))
            countLabel.text = "\(data!.subscribe_count) 订阅 | 总帖数 \(data!.total_updates)"
            desLabel.text = data?.placeholder
        }
    }
    // MARK: - lazy

    private lazy var backBtn:UIButton = {
        let btn = UIButton()
        btn.tag = 1
        return btn
    }()
    private lazy var backView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    private lazy var iconView: UIImageView = {
        let view = UIImageView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    private lazy var subscribeButton: UIButton = {
        let view: UIButton = UIButton.init(title: "订阅", color: BLACK_COLOR, fontSize: 12, target: self, actionName: nil)
        view.layer.borderColor = UIColor.orange.cgColor
        view.layer.borderWidth = 0.5
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 2
        view.backgroundColor = UIColor.orange
        return view
    }()
    private lazy var countLabel: UILabel = {
        let view = UILabel.init(title: "", fontSize: 10, color:WHITE_COLOR, screenInset: 20)
        return view
    }()
    private lazy var desLabel: UILabel = {
        let view = UILabel.init(title: "", fontSize: 10, color:WHITE_COLOR, screenInset: 20)
        return view
    }()
    // MARK: - deinit
    deinit {

        scrollView!.removeObserver(self, forKeyPath: "contentOffset")

    }
}
