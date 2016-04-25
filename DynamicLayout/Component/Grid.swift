//
//  Grid.swift
//  DynamicLayout
//
//  Created by Thomas Torp on 22/04/16.
//  Copyright © 2016 Schibsted. All rights reserved.
//

import Foundation
import Sugar
import Spots
import Brick
import UIKit

class Grid: GridSpot {
    required init(component: Component) {
        super.init(component: component)

        layout.sectionInset = UIEdgeInsetsMake(30, 10, 30, 10)
    }
}