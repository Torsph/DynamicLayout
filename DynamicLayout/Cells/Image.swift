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

    var size = CGSize(width: 0, height: 320)
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .ScaleAspectFill
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(imageView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(inout item: ViewModel) {
        optimize()

        if !item.image.isEmpty {
            imageView.image = nil
            imageView.fromURL(NSURL(string: item.image))
        }

        imageView.frame = contentView.frame
        item.size.height = 320
        item.size.width = UIScreen.mainScreen().bounds.width
    }
}
