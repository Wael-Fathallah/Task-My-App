//
//  CategoryVew.swift
//  Task My App
//
//  Created by Fathallah Wael on 11/30/17.
//  Copyright © 2017 Fathallah Wael. All rights reserved.
//

import UIKit

class CategoryVew: UIView {
    
    @IBOutlet weak var categoryNameLabel : UILabel!
    @IBOutlet weak var categoryColorView : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func setup(_ category : Category){
        self.categoryNameLabel.text = category.name
        self.categoryColorView.backgroundColor = UIColor(hex : category.colour!)
    }
    
    
}
