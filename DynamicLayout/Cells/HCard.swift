//
//  SearchCell.swift
//  DynamicLayout
//
//  Created by Thomas Torp on 25/04/16.
//  Copyright © 2016 Schibsted. All rights reserved.
//

import Foundation
import UIKit
import Sugar
import Spots
import Brick

class HCard : UICollectionViewCell {

    //Internal vars
    lazy var stackView : UIStackView = {
        let stack = UIStackView()
        stack.axis  = .Horizontal
        stack.distribution  = .Fill
        stack.alignment = .Leading
        stack.spacing   = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    lazy var stackViewTitles : UIStackView = {
        let stack = UIStackView()
        stack.axis  = .Vertical
        stack.distribution  = .FillEqually
        stack.alignment = .Fill
        stack.spacing   = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraintEqualToConstant(88).active = true
        imageView.widthAnchor.constraintEqualToConstant(88).active = true

        return imageView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFontOfSize(14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        }()

    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(12)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        stackViewTitles.addArrangedSubview(titleLabel)
        stackViewTitles.addArrangedSubview(subtitleLabel)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(stackViewTitles)
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

extension HCard: SpotConfigurable {

    var size: CGSize {
        get {
            return CGSize(width: 0, height: 88)
        }
        set {
            self.size = newValue
        }
    }

    func configure(inout item: ViewModel) {
        optimize()

        if !item.image.isEmpty {
            imageView.fromURL(NSURL(string: item.image))
        }
        
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle

        item.size.width = UIScreen.mainScreen().bounds.width
    }
}