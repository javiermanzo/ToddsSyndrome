//
//  UIViewController-Extension.swift
//  ToddsSyndrome
//
//  Created by Javier Roberto Manzo on 6/1/16.
//  Copyright © 2016 Javier Roberto Manzo. All rights reserved.
//

import UIKit

extension UIViewController {
    static func instanceWithDefaultNib() -> Self {
        let className = NSStringFromClass(self as! AnyClass).componentsSeparatedByString(".").last
        let bundle = NSBundle(forClass: self as! AnyClass)
        return self.init(nibName: className, bundle: bundle)
    }
}