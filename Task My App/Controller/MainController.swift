//
//  MainController.swift
//  Task My App
//
//  Created by Fathallah Wael on 11/29/17.
//  Copyright © 2017 Fathallah Wael. All rights reserved.
//

import UIKit

class MainController: UIViewController {
    
    //Outlets
    @IBOutlet weak var taskTableView:UITableView!
    
    //Global Vars
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var tasks : [Task] = []
    var selectIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reloadView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

//UI Setup extention
extension MainController {
    
    func viewSetup()  {
        self.taskTableView.delegate = self
        self.taskTableView.dataSource = self
        self.taskTableView.registerCellNib(TaskCell.self)
    }
    
    func reloadView(){
        self.fetchTasks()
        self.taskTableView.reloadData()
    }
}

//UITableViewDelegate extension
extension MainController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            self.dropTask(tasks[indexPath.row])
            self.tasks.remove(at: indexPath.row)
            self.taskTableView.deleteRows(at: [indexPath], with: .fade)
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectIndex = indexPath.row
        self.performSegue(withIdentifier: "EditTask" , sender: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 79
    }
    
}

//UITableViewDataSource extension
extension MainController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(self.tasks.count > 0){
            self.taskTableView.backgroundView = nil
            
        }
        else
        {
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: self.taskTableView.bounds.size.width, height: self.taskTableView.bounds.size.height))
            noDataLabel.numberOfLines = 0
            noDataLabel.text          = "No Tasks found."
            noDataLabel.textColor     = UIColor.gray
            noDataLabel.textAlignment = .center
            self.taskTableView.backgroundView  = noDataLabel
            self.taskTableView.separatorStyle  = .none
        }
        
        return self.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.taskTableView.dequeueReusableCell(withIdentifier: TaskCell.identifier) as! TaskCell
        cell.setupCell(task: tasks[indexPath.row])
        
        return cell
    }
    
    
}

//function extension
extension MainController {
    
    func fetchTasks() {
        do {
            self.tasks = try context.fetch(Task.fetchRequest())
        }
        catch {
            print("Fetching Catched")
        }
    }
    
    func dropTask(_ task : Task){
        
        context.delete(task)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
    }
    
}

//segue extension
extension MainController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "EditTask"){
            if let destination = segue.destination as? TaskController{
                destination.isFrech = false
                destination.task = self.tasks[self.selectIndex]
            }
        }
    }
}
