//
//  NSDate-Extension.swift
//  ToddsSyndrome
//
//  Created by Javier Roberto Manzo on 6/1/16.
//  Copyright © 2016 Javier Roberto Manzo. All rights reserved.
//

import Foundation

extension NSDate {
    var age: Int {
        return NSCalendar.currentCalendar().components(.Year, fromDate: self, toDate: NSDate(), options: []).year
    }
}