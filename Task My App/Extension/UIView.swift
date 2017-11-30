//
//  UIView.swift
//  Task My App
//
//  Created by Fathallah Wael on 11/30/17.
//  Copyright © 2017 Fathallah Wael. All rights reserved.
//

import UIKit

extension UIView {
    class func loadNib<T: UIView>(_ viewType: T.Type) -> T {
        let className = String.className(viewType)
        return Bundle(for: viewType).loadNibNamed(className, owner: nil, options: nil)!.first as! T
    }
    
    class func loadNib() -> Self {
        return loadNib(self)
    }
}
