//
//  Image.swift
//  DynamicLayout
//
//  Created by Thomas Torp on 22/04/16.
//  Copyright © 2016 Schibsted. All rights reserved.
//

import UIKit
import Sugar
import Spots
import Brick

class Image : UICollectionViewCell, SpotConfigurable {

    var size = CGSizeMake(200, 200)
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .ScaleAspectFit
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(imageView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // The first cell must be the larges one.
    func configure(inout item: ViewModel) {
        optimize()

        if item.size.height == 0 {
            item.size = size
        } else if item.size.width == 0 {
            item.size = CGSizeMake(UIScreen.mainScreen().bounds.width, size.height)
        }

        if !item.image.isEmpty {
            imageView.image = nil
            imageView.fromURL(NSURL(string: item.image))
        }


        imageView.frame.size = item.size

    }
}
