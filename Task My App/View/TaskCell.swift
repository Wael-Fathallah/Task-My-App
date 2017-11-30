//
//  TaskCell.swift
//  Task My App
//
//  Created by Fathallah Wael on 11/29/17.
//  Copyright © 2017 Fathallah Wael. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {

    @IBOutlet weak var taskDayLabel : UILabel!
    @IBOutlet weak var taskMonthLabel : UILabel!
    @IBOutlet weak var taskTimeLabel : UILabel!
    @IBOutlet weak var taskNameLabel : UILabel!
    
    @IBOutlet weak var taskColorView : UIView!
    
    class var identifier: String { return String.className(self) }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupCell (task: Task){
        //"yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let dateFormatter = DateFormatter()
        
        if let completionDate = task.completionDate as? Date {
            
            dateFormatter.dateFormat = "dd"
            self.taskDayLabel.text = dateFormatter.string(from: completionDate)
            
            dateFormatter.dateFormat = "MMM"
            self.taskMonthLabel.text = dateFormatter.string(from: completionDate)
            
            dateFormatter.dateFormat = "HH:mm"
            self.taskTimeLabel.text = dateFormatter.string(from: completionDate)
        }
        
        if let name = task.name {
            self.taskNameLabel.text = name
        }
        
        if let colour = task.category?.colour {
            self.taskColorView.backgroundColor = UIColor(hex : colour)
        }
        
    }
}
