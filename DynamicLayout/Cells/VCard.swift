//
//  SquareCell.swift
//  DynamicLayout
//
//  Created by Thomas Torp on 22/04/16.
//  Copyright © 2016 Schibsted. All rights reserved.
//

import UIKit
import Sugar
import Spots
import Brick

class VCard : UICollectionViewCell {

    //Internal vars
    lazy var stackView : UIStackView = {
        let stack = UIStackView()
        stack.axis  = .Vertical
        stack.distribution  = .Fill
        stack.alignment = .Center
        stack.spacing   = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .ScaleAspectFit
        imageView.height = 88
        imageView.width = 88
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraintEqualToConstant(88).active = true
        return imageView
    }()

    //Must use unowned because of Reference Cycles
    //https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html#//apple_ref/doc/uid/TP40014097-CH20-ID48
    lazy var titleLabel: UILabel = { [unowned self] in
        let label = UILabel(frame: self.contentView.frame)
        label.textColor = UIColor.blackColor()
        label.textAlignment = .Center
        label.font = UIFont.systemFontOfSize(14)
        label.numberOfLines = 2
        return label
        }()

    lazy var subtitleLabel: UILabel = { [unowned self] in
        let label = UILabel(frame: self.contentView.frame)
        label.textAlignment = .Center
        label.font = UIFont.systemFontOfSize(10)
        label.textColor = UIColor.lightGrayColor()
        label.numberOfLines = 2
        return label
        }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        contentView.addSubview(stackView)

        //Need to add the constraints after the stackview has been added to the view
        let viewsDictionary = ["stackView":stackView]
        let stackView_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[stackView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
        let stackView_V = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[stackView]-0-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: viewsDictionary)
        contentView.addConstraints(stackView_H)
        contentView.addConstraints(stackView_V)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension VCard: SpotConfigurable {

    var size: CGSize {
        get {
            return CGSize(width: 0, height: 120)
        }
        set {
            self.size = newValue
        }
    }

    func configure(inout item: ViewModel) {
        optimize()

        if !item.image.isEmpty {
            imageView.fromURL(NSURL(string: item.image))
//            imageView.fromDummyImageRandomColor(width: 88, height: 88)
        }

        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle

        titleLabel.sizeToFit()
        subtitleLabel.sizeToFit()

        item.size.height = imageView.height + titleLabel.height + subtitleLabel.height + 20
    }
}