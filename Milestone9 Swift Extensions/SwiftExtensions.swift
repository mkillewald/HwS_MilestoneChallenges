//
//  SwiftExtensions.swift
//  Project15
//
//  Created by Mike Killewald on 8/27/17.
//  Copyright © 2017 Gameaholix. All rights reserved.
//

import UIKit
import GameplayKit

// extension 1: is an integer even?
extension Integer {
    func isEven() -> Bool {
        return self % 2 == 0
    }
}

// extension 2: length of string
extension String {
    var length: Int {
        return self.characters.count
    }
}

// extension 3: animate out a UIView
extension UIView {
    func bounceOut(duration: TimeInterval) {
        UIView.animate(withDuration: duration) { [unowned self] in
            self.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        }
    }
}

// extension 4: wrap GameplayKit shuffling
extension Array {
    mutating func shuffle() {
        self = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: self) as! Array
    }
}

// extension 5: remove an item from an Array
extension Array where Element: Comparable {
    mutating func remove(item: Element) {
        if let index = self.index(of: item) {
            self.remove(at: index)
        }
    }
}
