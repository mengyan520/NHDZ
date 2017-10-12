//
//  HomeDetailTableViewCell.swift
//  NHDZ
//
//  Created by Youcai on 2017/8/4.
//  Copyright © 2017年 mm. All rights reserved.
//

import UIKit

class HomeDetailTableViewCell: HomeTableViewCell {

    // MARK: - Model
    override var viewModel: GroupViewModel? {
        didSet {




        }


    }

// MARK: - setUI
override func setUI() {
    super.setUI()
    
}

  // MARK: - Lazy
    private  lazy var nameLabel: UILabel = {
        let view = UILabel.init(title: "", fontSize: 12, color: BLACK_COLOR, screenInset: 0)
        return view
    }()
}
