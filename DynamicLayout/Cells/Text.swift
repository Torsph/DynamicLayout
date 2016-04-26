//
//  Text.swift
//  DynamicLayout
//
//  Created by Thomas Torp on 22/04/16.
//  Copyright © 2016 Schibsted. All rights reserved.
//

import UIKit
import Sugar
import Spots
import Brick

class Text: UICollectionViewCell {

    //Internal vars
    lazy var stackView : UIStackView = {
        let stack = UIStackView()
        stack.axis  = UILayoutConstraintAxis.Vertical
        stack.distribution  = UIStackViewDistribution.Fill
        stack.alignment = UIStackViewAlignment.Fill
        stack.spacing   = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFontOfSize(18)
        label.numberOfLines = 0
        return label
        }()

    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(14)
        label.numberOfLines = 0
        return label
        }()

    lazy var paddedStyle: NSParagraphStyle = {
        let style = NSMutableParagraphStyle()
        style.alignment = .Left
        style.firstLineHeadIndent = 10.0
        style.headIndent = style.firstLineHeadIndent
        style.tailIndent = -style.firstLineHeadIndent
        return style
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

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

extension Text: SpotConfigurable {

    var size: CGSize {
        get {
            return CGSize(width: 0, height: 320)
        }
        set {
            self.size = newValue
        }
    }

    func configure(inout item: ViewModel) {
        optimize()

        titleLabel.attributedText = NSAttributedString(string: item.title, attributes: [NSParagraphStyleAttributeName : paddedStyle])
        subtitleLabel.attributedText = NSAttributedString(string: item.subtitle, attributes: [NSParagraphStyleAttributeName : paddedStyle])

        titleLabel.sizeToFit()
        subtitleLabel.sizeToFit()

        item.size.height = titleLabel.height + subtitleLabel.height + 20
        item.size.width = UIScreen.mainScreen().bounds.width
    }
}
