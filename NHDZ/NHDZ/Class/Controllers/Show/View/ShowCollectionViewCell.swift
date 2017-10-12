//
//  ShowCollectionViewCell.swift
//  NHDZ
//
//  Created by Youcai on 2017/8/1.
//  Copyright © 2017年 mm. All rights reserved.
//

import UIKit
class ShowCollectionViewCell: UICollectionViewCell {

    // MARK: -  init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - setUI
    func setUI() {
        contentView.addSubview(iconView)
        iconView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(contentView.snp.edges)
        }

    }
    // MARK: - Model
    var viewModel:GroupViewModel? {
        didSet {
            
            iconView.kf.setImage(with: viewModel?.imgUrls?.first)

        }
    }
    // MARK: - Lazy
    lazy var iconView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
}
