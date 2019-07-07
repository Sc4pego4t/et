//
//  CalendarPage.swift
//  EasyTask
//
//  Created by Hubert on 05/07/2019.
//  Copyright © 2019 Hubert. All rights reserved.
//

import Foundation
import UIKit
import Koyomi


class CalendarPage: UIViewController{
    
    let koyomi = Koyomi(frame: CGRect(x: 5, y: 185, width: 365, height: 420) , sectionSpace: 1.5, cellSpace: 0.5, inset: .zero, weekCellHeight: 25)
    
    func koyomi(_koyomi: Koyomi, currentDateString dateString: String){
        print(dateString)
    }
    
    func koyomi(_ Koyomi: Koyomi, didSelect date: Date, forItemAt indexPath: IndexPath){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        let string = formatter.string(from: date)
        print(string)
       
    }
    
    public func CalandarView(){
        koyomi.display(in: .current)
        koyomi.isHiddenOtherMonth = false
        koyomi.selectionMode = .single(style: .circle)
        let today = Date()
        koyomi.select(date: today)
        let customColorScheme = (dayBackgrond: UIColor(red: 155/255, green: 150/255, blue: 113/255, alpha: 0.3),
                                 weekBackgrond: UIColor(red: 155/255, green: 150/255, blue: 113/255, alpha: 0.8),
                                 week: UIColor.black,
                                 weekday: UIColor.white,
                                 holiday: (saturday: UIColor(red: 183/255, green: 57/255, blue: 21/255, alpha: 1), sunday: UIColor(red: 183/255, green: 57/255, blue: 21/255, alpha: 1)),
                                 otherMonth: UIColor(red: 0, green: 0, blue: 0, alpha: 0.8),
                                 separator: UIColor(red: 1, green: 1, blue: 1, alpha: 0))
        koyomi.style = KoyomiStyle.custom(customColor: customColorScheme)
        view.addSubview(koyomi)
    }
    func monthDisplayer(){
        monthLabel.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        monthLabel.font = UIFont(name: "AmericanTypeWriter", size: 35)
        monthLabel.textColor = UIColor.black
        monthLabel.textAlignment = .center
        let shown = koyomi.currentDateString()
        let formatter = DateFormatter()
        formatter.dateFormat = "M/yyyy"
        let shownDate = formatter.date(from: shown)
        formatter.dateFormat = "dd/MM/yyyy"
        let index = Calendar.current.component(.month, from: shownDate!)
        let month = Calendar.current.monthSymbols[index - 1]
        monthLabel.text = month
        
        
    }
    @IBOutlet weak var monthLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CalandarView()
        nextButton()
        previousButton()
        currentButton()
        monthDisplayer()
        
        
        
    }
    
    func nextButton(){
        let button = UIButton()
        button.frame = CGRect(x: view.frame.width - 130, y: 50, width: 100, height: 50)
        button.backgroundColor = UIColor.clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.titleLabel?.font = UIFont(name: "AmericanTypeWriter", size: 23)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitle("Next", for: .normal)
        button.addTarget(self, action: #selector(nextMonth), for: .touchUpInside)
        self.view.addSubview(button)
        
    }
    
    @objc func nextMonth(sender: UIButton!){
        koyomi.display(in: .next)
        monthDisplayer()
    }
    func previousButton(){
        let button = UIButton(frame: CGRect(x: 30, y: 50, width: 100, height: 50))
        button.setTitle("Previous", for: .normal)
        button.backgroundColor = UIColor.clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.titleLabel?.font = UIFont(name: "AmericanTypeWriter", size: 23)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(previousMonth), for: .touchUpInside)
        self.view.addSubview(button)
        
    }
    
    @objc func previousMonth(sender: UIButton!){
        koyomi.display(in: .previous)
        monthDisplayer()
    }
    
    func currentButton(){
        let button = UIButton(frame: CGRect(x: (view.frame.width / 2) - 50, y: 50, width: 100, height: 50))
        button.setTitle("current", for: .normal)
        button.backgroundColor = UIColor.clear
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.titleLabel?.font = UIFont(name: "AmericanTypeWriter", size: 23)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(currentMonth), for: .touchUpInside)
        self.view.addSubview(button)
        
    }
    
    @objc func currentMonth(sender: UIButton!){
        koyomi.display(in: .current)
        monthDisplayer()
    }
    
    
    
    
}



