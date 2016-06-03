//
//  JSON-Extension.swift
//  ToddsSyndrome
//
//  Created by Javier Roberto Manzo on 6/2/16.
//  Copyright © 2016 Javier Roberto Manzo. All rights reserved.
//

import Foundation
import SwiftyJSON

extension JSON {
    public var date: NSDate? {
        get {
            if let str = self.string {
                return JSON.jsonDateFormatter.dateFromString(str)
            }
            return nil
        }
    }
    
    private static let jsonDateFormatter: NSDateFormatter = {
        let fmt = NSDateFormatter()
        fmt.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        fmt.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        return fmt
    }()
}