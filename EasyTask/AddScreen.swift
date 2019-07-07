//
//  AddScreen.swift
//  EasyTask
//
//  Created by Hubert on 30/06/2019.
//  Copyright © 2019 Hubert. All rights reserved.
//

import Foundation
import UIKit



class addScreen: UIViewController {
    @IBOutlet weak var TitleField: UITextField!
    @IBOutlet weak var DescriptionField: UITextView!  // These few lines link the objects on the "Add" screen
    @IBOutlet weak var DateSelector: UIDatePicker!
    struct savedData {  // This struct creates keys for saving data
        static let importanceKey = "importance" // Importance is saved as a string
        static let titleOfTask = "taskName"   // Task title is set as a string
        static let dateOfTask = "taskDate"  // Stored as string
        static let descriptionOfTask = "taskDescription" // Task description is also saved as a string
        static let taskInfo = "taskInfo"  // All stored as dictionary
        static let buttonPressed = "buttonPressed"
        static let tasks = "tasksSaved"
        static let dateSelected = "dateSelected"
    }
    
    

    var importance = ""
    @IBAction func GreenButton(_ sender: UIButton) {importance = "Green"}
    @IBAction func YellowButton(_ sender: UIButton) {importance = "Yellow"}  // Here the functions of colored buttons are made
    @IBAction func RedButton(_ sender: UIButton) {importance = "Red"}
    
    
    @IBAction func SaveButton(_ sender: UIButton) {    // This is where the save button finishes and creates a new task after which it deletes recent info about the task
        if importance == "Green"{
            let defaults = UserDefaults.standard
            defaults.set("Green", forKey: "importance")
        }
        if importance == "Yellow"{
            let defaults = UserDefaults.standard
            defaults.set("Yellow", forKey: "importance")
        }
        if importance == "Red"{
            let defaults = UserDefaults.standard
            defaults.set("Red", forKey: "importance")
        }
        if importance == ""{
            importance = "Green"
            let defaults = UserDefaults.standard
            defaults.set("Green", forKey: "importance")
        }
        let defaults = UserDefaults.standard
        let taskName = TitleField.text
        defaults.set(taskName , forKey: "taskName")
        
        let descriptionOfTask = DescriptionField.text
        defaults.set(descriptionOfTask, forKey: "taskDescription")
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = DateFormatter.Style.short
        timeFormatter.dateFormat = "dd/MM/yy"
        let strDate = timeFormatter.string(from: DateSelector.date)
        defaults.set(strDate, forKey: "taskDate")
        
        defaults.set(true, forKey: "buttonPressed")
        
        
        
        
    
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: "buttonPressed")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TitleField.placeholder = "Write Title here..."    // Thsi function decides what and when something loads
        TitleField.alpha = 1
        DescriptionField.alpha = 0.4
    }
}
