//
//  CategoryController.swift
//  Task My App
//
//  Created by Fathallah Wael on 11/29/17.
//  Copyright © 2017 Fathallah Wael. All rights reserved.
//

import UIKit


protocol CategoryControllerDelegate: class {
    func categoryDidAdd(_ category : Category)
}

class CategoryController: UIViewController {

    //Outlet
    @IBOutlet weak var categoryName: UITextField!
    @IBOutlet weak var categoryColor: UITextField!
    
    //Delegate
    weak var delegate: CategoryControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showAnimate()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

//UI Setup extention
extension CategoryController {
    
    func viewSetup()  {
        
    }
}

//Action extension
extension CategoryController {
    
    @IBAction func save(_ sender : UIButton){
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let category = Category(context: context)
        category.name = categoryName.text!
        category.colour = categoryColor.text!
        
        // Save the data to coredata
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        delegate?.categoryDidAdd(category)
        self.removeAnimate()
    }
    
    @IBAction func cancel(_ sender : UIButton){

        self.removeAnimate()
    }
}

//Show & Hide extension
extension CategoryController {
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
        /*if let parentVC = self.parent {
         
         //parentVC.navigationItem.leftBarButtonItem.(true, animated: true)
         }*/
        
    }
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                /*if let parentVC = self.parent {
                 
                 //parentVC.navigationItem.setHidesBackButton(false, animated: true)
                 }*/
                self.view.removeFromSuperview()
            }
        });
    }
    
}
