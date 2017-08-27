//
//  Integer+isEven.swift
//  Milestone9
//
//  Created by Mike Killewald on 8/27/17.
//  Copyright © 2017 Gameaholix. All rights reserved.
//

import Foundation

extension Integer {
    func isEven() -> Bool {
        if self % 2 == 0 {
            return true
        } else {
            return false
        }
    }
}
