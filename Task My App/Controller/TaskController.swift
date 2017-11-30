//
//  TaskController.swift
//  Task My App
//
//  Created by Fathallah Wael on 11/29/17.
//  Copyright © 2017 Fathallah Wael. All rights reserved.
//

import UIKit

class TaskController: UIViewController {
    
    //Outlet
    @IBOutlet weak var addUpdateButton: UIBarButtonItem!
    @IBOutlet weak var taskNameField: UITextField!
    @IBOutlet weak var categoriesPicker: UIPickerView!
    @IBOutlet weak var completionDatePicker: UIDatePicker!

    //Global Vars
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var isFrech : Bool = true
    var task : Task?
    var categories : [Category] = []
    var categoriesTitles = ["Select"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewSetup()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
//UI Setup extention
extension TaskController {
    
    func viewSetup()  {
        self.categoriesPicker.delegate = self
        self.categoriesPicker.dataSource = self
        self.fetchCategories()
        self.updateTitles()
        self.categoriesPicker.reloadAllComponents()
        if (!isFrech){
            let index = categories.index(of: (task?.category)!)
            self.categoriesPicker.selectRow(index ?? 0, inComponent: 0, animated: false)
            self.taskNameField.text = task?.name
        }
    }
}

//Action extension
extension TaskController {
    
    @IBAction func addOrUpdate(_ sender : UIBarButtonItem){
        
        let isvalid = modelValidator()
        
        if (isvalid.isValid){
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            if ( isFrech){
                
                let task = Task(context: context)
                task.name = taskNameField.text!
                task.completionDate = completionDatePicker.date as NSDate?
                task.category = self.categories[self.categoriesPicker.selectedRow(inComponent: 0) - 1]
                
            } else {
                
                task?.name = taskNameField.text!
                task?.completionDate = completionDatePicker.date as NSDate?
                task?.category = self.categories[self.categoriesPicker.selectedRow(inComponent: 0) - 1]
                
            }
            
            
            // Save the data to coredata
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            let _ = navigationController?.popViewController(animated: true)
        } else {
            let alert = UIAlertController(title: "Alert", message: isvalid.message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
}

//UIPickerViewDataSource extension
extension TaskController : UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoriesTitles.count;
    }
    
}

//UIPickerViewDelegate extension
extension TaskController : UIPickerViewDelegate{
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoriesTitles[row] as String
    }
}



//Fonction extension
extension TaskController {
    
    
    func fetchCategories() {
        do {
            self.categories = try context.fetch(Category.fetchRequest())
        }
        catch {
            print("Fetching Catched")
        }
    }
    
    func updateTitles(){
        self.categoriesTitles.removeAll()
        self.categoriesTitles.append("Select")
        for category in self.categories {
            self.categoriesTitles.append(category.name!)
        }
    }
    
    func modelValidator() -> (isValid : Bool, message : String){
        
        guard self.taskNameField.text?.trimmingCharacters(in: .whitespaces).characters.count != 0 else {
            return (false, "Please Enter The Name")
        }
        guard self.categoriesTitles[self.categoriesPicker.selectedRow(inComponent: 0)] != "Select" else {
            return (false, "Please Select Category")
        }
        
        return (true, "")
    }
}
