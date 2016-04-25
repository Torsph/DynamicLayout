//
//  UIImageView+Loading.swift
//  DynamicLayout
//
//  Created by Thomas Torp on 21/04/16.
//  Copyright © 2016 Schibsted. All rights reserved.
//

import UIKit

extension UIImageView {
    func fromURL(url:NSURL?) {

        guard let url = url else {
                return
        }

        NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
            guard let httpURLResponse = response as? NSHTTPURLResponse where httpURLResponse.statusCode == 200,
                let data = data,
                let image = UIImage(data: data)
                else {
                    return
            }

            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.image = image
                self.invalidateIntrinsicContentSize()
            }
        }).resume()
    }

    private func randomColor() -> String {
        let r = arc4random_uniform(256)
        let g = arc4random_uniform(256)
        let b = arc4random_uniform(256)

        return String(format:"%.2X%.2X%.2X", r, g, b)
    }

    func fromDummyImageRandomColor(width width: Int = 200, height: Int = 200) {
        let background = randomColor()
        let foreground = randomColor()

        fromDummyImage(width: width, height: height, backColorHex: background, frontColorHex: foreground)
    }

    func fromDummyImage(width width: Int = 200, height: Int = 200, backColorHex: String = "000000", frontColorHex: String = "ffffff") {
        let url = NSURL(string: templateImage(width: width, height: height, backColorHex: backColorHex, frontColorHex: frontColorHex))
        fromURL(url)
    }

    func templateImage(width width: Int = 200, height: Int = 200, backColorHex: String = "000000", frontColorHex: String = "ffffff") -> String {
        let scale = Int(UIScreen.mainScreen().scale)
        return "http://dummyimage.com/\(width*scale)x\(height*scale)/\(backColorHex)/\(frontColorHex)"
    }
}