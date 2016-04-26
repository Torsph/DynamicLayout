//
//  ViewController.swift
//  DynamicLayout
//
//  Created by Thomas Torp on 21/04/16.
//  Copyright © 2016 Schibsted. All rights reserved.
//

import UIKit
import Spots

class ViewController: UIViewController {
    @IBOutlet weak var version1StackView: UIStackView!
    @IBOutlet weak var version2StackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.whiteColor()

        version1StackView.subviews.forEach {
            if $0 is UIButton {
                $0.layer.borderColor = UIColor.grayColor().CGColor
                $0.layer.borderWidth = 1.5
                $0.layer.cornerRadius = 7.5
            }
        }

        version2StackView.subviews.forEach {
            if $0 is UIButton {
                $0.layer.borderColor = UIColor.grayColor().CGColor
                $0.layer.borderWidth = 1.5
                $0.layer.cornerRadius = 7.5
            }
        }
    }

    @IBAction func version1SearchList(sender: AnyObject) {
        loadFile("search-list-v1")
    }
    @IBAction func version1ObjectPage(sender: AnyObject) {
        loadFile("object-page-v1")
    }
    @IBAction func version2SearchList(sender: AnyObject) {
        loadFile("search-list-v2")
    }
    @IBAction func version2ObjectPage(sender: AnyObject) {
        loadFile("object-page-v2")
    }
    @IBAction func versionSyncAndroid(sender: AnyObject) {
        loadFile("http://pastebin.com/raw/mtE4rkb5")
    }
    private func loadFile(fileToLoad: String) {

        var data: NSData?

        if fileToLoad.hasPrefix("http") {
            data = NSData(contentsOfURL: NSURL(string: fileToLoad)!)
        } else {
            let bundlePath = NSBundle.mainBundle().pathForResource(fileToLoad, ofType: "json")
            data = NSFileManager.defaultManager().contentsAtPath(bundlePath!)
        }

        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? [String : AnyObject]
            if let json = json {
                let spots = Parser.parse(json)
                let controller = SpotsController(spots: spots)
                navigationController?.pushViewController(controller, animated: true)
            }
        } catch {
            let alertController = UIAlertController(title: "Error", message: "Unable to resolve JSON", preferredStyle: .Alert)
            let doneAction = UIAlertAction(title: "Okay", style: .Default, handler: nil)
            alertController.addAction(doneAction)
            presentViewController(alertController, animated: true, completion: nil)
        }
    }
}

