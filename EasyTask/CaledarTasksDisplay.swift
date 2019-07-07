//
//  CaledarTasksDisplay.swift
//  EasyTask
//
//  Created by Hubert on 06/07/2019.
//  Copyright © 2019 Hubert. All rights reserved.
//

import Foundation
import UIKit

class CalendarTasksDisplayer: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let NumOfCell = 10
        return NumOfCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! BunchCells
        cell.backgroundColor = UIColor.white
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    @IBOutlet weak var DayLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    weak var tableView: UITableView!
    
    var dateShown = Date()
    override func viewWillAppear(_ animated: Bool) {
        dateShown = UserDefaults.standard.object(forKey: "dateSelected") as! Date
        setupTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        func DateOfDay(){  // Function calculating todays date
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yy"
            let dateOfDay = formatter.string(from: date)
            DateLabel.text = dateOfDay
        }
        
        func DayOfWeek(){   // Function calculating the day of the week
            let index = Calendar.current.component(.weekday, from: Date())
            let dayOfWeek = Calendar.current.weekdaySymbols[index - 1]
            DayLabel.text = dayOfWeek
        }
        
        DateOfDay()
        DayOfWeek()
        
        
        
    }
    
    let tableview: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor.white
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    func setupTableView(){
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(BunchCells.self, forCellReuseIdentifier: "cellId")
        tableview.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        view.addSubview(tableview)
        
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 170),
            tableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableview.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableview.leftAnchor.constraint(equalTo: self.view.leftAnchor)])
    }
    
    
}

class BunchCells: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "Day 1"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    
    
    func setupView(){
        addSubview(cellView)
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor)])
        
        dayLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        dayLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        dayLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        dayLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 20).isActive = true
        
    }
    
}











