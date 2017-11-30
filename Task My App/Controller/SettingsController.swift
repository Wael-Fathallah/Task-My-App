//
//  SettingsController.swift
//  Task My App
//
//  Created by Fathallah Wael on 11/29/17.
//  Copyright © 2017 Fathallah Wael. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {

    //Outlet
    @IBOutlet var categoriesStack: UIStackView!
    
    //Global Vars
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var categories : [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewSetup()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
//UI Setup extention
extension SettingsController {
    
    func viewSetup()  {
        self.fetchCategories()
        for category in categories {
            self.appendCategoryView(category: category)
        }
    }
}

//Action extension
extension SettingsController {
    
    @IBAction func changeNotification(_ sender : UISwitch){
        
    }
    
    @IBAction func addCategory(_ sender : UIButton){
        
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CategoryControllerSID") as! CategoryController
        popOverVC.delegate = self
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        
        popOverVC.didMove(toParentViewController: self)
        
    }
}

//Fonction extension
extension SettingsController {
    
    
    func fetchCategories() {
        do {
            self.categories = try context.fetch(Category.fetchRequest())
        }
        catch {
            print("Fetching Catched")
        }
    }
    
    func appendCategoryView( category : Category){
        
        let categoryToAppend : CategoryVew = CategoryVew.loadNib()
        categoryToAppend.setup(category)
        self.categoriesStack.insertArrangedSubview(categoryToAppend, at: 1)
        
    }
}

//Add Caregory Delegate
extension SettingsController : CategoryControllerDelegate{
    func categoryDidAdd(_ category : Category){
        self.appendCategoryView(category: category)
    }
}
