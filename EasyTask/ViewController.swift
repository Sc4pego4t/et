//
//  ViewController.swift
//  EasyTask
//
//  Created by Hubert on 29/06/2019.
//  Copyright © 2019 Hubert. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let NumOfCell = currentTasks.count
        return NumOfCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! BunchOfCells
        cell.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        cell.label.text = currentTasks[indexPath.item]["Title"]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
	
    @IBOutlet weak var DayDisplay: UILabel!
    @IBOutlet weak var dateDisplay: UILabel!  // Again this is where the objects on the screen are connected
    
    let vc = addScreen()
    var tasks: [[String:String]] = [] as Array
    var currentTasks: [[String:String]] = [] as Array
    var taskInfo: [String:String] = ["Title":"", "Importance":"", "Date":"", "Description":""]
    var shownDate = Date()
	
	weak var tableView: UITableView!
	let tableview: UITableView = {
		let tv = UITableView()
		tv.translatesAutoresizingMaskIntoConstraints = false
		tv.separatorColor = UIColor.white
		return tv
	}()
    
    func setupTableView(){
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(BunchOfCells.self, forCellReuseIdentifier: "cellId")
        tableview.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        view.addSubview(tableview)
        
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 170),
            tableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableview.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableview.leftAnchor.constraint(equalTo: self.view.leftAnchor)])
    }
    
    
    override func viewDidLoad() {    // The viewDidLoad func decides how things appaer on the screen
        super.viewDidLoad()
        UserDefaults.standard.set(false, forKey: "buttonPressed")
        setupTableView()
        dateForwardButton()
        dateBackButton()
        displayCurrentTasks()
        
        
        func DateOfDay(){  // Function calculating todays date
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yy"
            let dateOfDay = formatter.string(from: date)
            dateDisplay.text = dateOfDay
        }
        
        func DayOfWeek(){   // Function calculating the day of the week
            let index = Calendar.current.component(.weekday, from: Date())
            let dayOfWeek = Calendar.current.weekdaySymbols[index - 1]
            DayDisplay.text = dayOfWeek
        }
        
        DateOfDay()
        DayOfWeek()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func dateForwardButton(){
        let button = UIButton(frame: CGRect(x: view.frame.width / 2, y: 0, width: view.frame.width / 2, height: 170))
        let image = UIImage(named: "right-arrow.png")
        button.setImage(image, for: .normal)
        button.alpha = 0.25
        button.addTarget(self, action: #selector(dateForward) , for: .touchUpInside)
        self.view.addSubview(button)
        self.view.insertSubview(button, at: 1)

    }
    func dateBackButton(){
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width / 2, height: 170))
        let image = UIImage(named: "LeftArrow")
        button.setImage(image, for: .normal)
        button.alpha = 0.25
        button.addTarget(self, action: #selector(dateBack), for: .touchUpInside)
        self.view.addSubview(button)
        self.view.insertSubview(button, at: 1)
        
    }
    
    @objc func dateBack(sender: UIButton!){
        let today = shownDate
        let nextDate = Calendar.current.date(byAdding: .day, value: -1, to: today)
        shownDate = nextDate!
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        let newDate = formatter.string(from: nextDate!)
        dateDisplay.text = newDate
        
        let index = Calendar.current.component(.weekday, from: shownDate)
        let dayOfWeek = Calendar.current.weekdaySymbols[index - 1]
        DayDisplay.text = dayOfWeek
        print(currentTasks)
        currentTasks.removeAll()
        displayCurrentTasks()
        //tableview.reloadData()
        
        
    }
    @objc func dateForward(sender: UIButton!){
        let today = shownDate
        let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: today)
        shownDate = nextDate!
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        let newDate = formatter.string(from: nextDate!)
        dateDisplay.text = newDate
        
        let index = Calendar.current.component(.weekday, from: shownDate)
        let dayOfWeek = Calendar.current.weekdaySymbols[index - 1]
        DayDisplay.text = dayOfWeek
        print(currentTasks)
        currentTasks.removeAll()
        displayCurrentTasks()
        tableview.reloadData()
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        createTask()
        let decider = UserDefaults.standard.bool(forKey: "buttonPressed")
        if decider == true{ currentTasks.removeAll()  ; displayCurrentTasks() }
        
        
        
        
        
    }

    func createTask(){
        let decider = UserDefaults.standard.bool(forKey: "buttonPressed")
        if (decider == true){
            let nameOfTask = UserDefaults.standard.object(forKey: "taskName") as! String
            let importanceOfTask = UserDefaults.standard.object(forKey: "importance") as! String
            let dateOfTask = UserDefaults.standard.object(forKey: "taskDate") as! String
            let desOfTask = UserDefaults.standard.object(forKey: "taskDescription") as! String
            taskInfo["Title"] = nameOfTask
            taskInfo["Importance"] = importanceOfTask
            taskInfo["Date"] = dateOfTask
            taskInfo["Description"] = desOfTask
            tasks.append(taskInfo)
            UserDefaults.standard.set(tasks, forKey: "tasksSaved")
            
            
        }
        
    }
    func displayCurrentTasks(){
        let tasksSaved = UserDefaults.standard.mutableArrayValue(forKey: "tasksSaved")
        //UserDefaults.standard.removeObject(forKey: "tasksSaved") // Deletes the data svaed
        for i in tasksSaved{
            let task = tasksSaved.index(of: i)
            currentTasks.append(tasksSaved[task] as! [String : String])
        }
        
        for i in currentTasks{
            let task = currentTasks.index(of: i)
            var dateOfTask = currentTasks[task!]["Date"]
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yy"
            let shownDate = formatter.string(from: self.shownDate)
            let DateOfTask = formatter.date(from: dateOfTask!)
            dateOfTask = formatter.string(from: DateOfTask!)
            if dateOfTask != shownDate{
                currentTasks.remove(at: currentTasks.index(of: i)!)
        
            }
        }
        tableview.reloadData()
        
        
    }
    


    class MyTabBarController: UITabBarController{
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.selectedIndex = 1
        }
        
    }

class BunchOfCells: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 155/255, green: 150/255, blue: 113/255, alpha: 0.5)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "NICE"
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupView(){
        addSubview(cellView)
        cellView.addSubview(label)
        self.selectionStyle = .none
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor)])
        
        label.heightAnchor.constraint(equalToConstant: 200).isActive = true
        label.widthAnchor.constraint(equalToConstant: 200).isActive = true
        label.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 20).isActive = true
    }
    

}

    



    

}

