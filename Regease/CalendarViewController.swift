//
//  CalendarViewController.swift
//  Regease
//
//  Created by Karol Stępień on 27.11.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarViewController: UIViewController, JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var calendarView: JTAppleCalendarView!
    var workingDays: [Int] = []
    var workingHours: [String] = []
    var calendarViewModel: CalendarViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.dataSource = self
        calendarView.delegate = self
        calendarView.registerCellViewXib(file: "CalendarDateCell")
        calendarView.cellInset = CGPoint(x: 0, y: 0)

        if calendarViewModel == nil {
            calendarViewModel = CalendarViewModel()
        }
        
        if let realmWorkingDays = PersistenceManager.sharedInstance.settingForKey(key: Settings.WorkingDays) {
            let stringWorkingDays = realmWorkingDays.value.components(separatedBy: ",")
            for day in stringWorkingDays {
                workingDays.append(Int(day)!)
            }
        }
        
        automaticallyAdjustsScrollViewInsets = false
        // Do any additional setup after loading the view, typically from a nib.
    }

    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        
        let startDate = formatter.date(from: "2016 02 01")! // You can use date generated from a formatter
        let endDate = Date()                                // You can also use dates created from this function
        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate,
                                                 numberOfRows: 6, // Only 1, 2, 3, & 6 are allowed
            calendar: Calendar.current,
            generateInDates: .forAllMonths,
            generateOutDates: .tillEndOfGrid,
            firstDayOfWeek: .monday)
        return parameters
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplayCell cell: JTAppleDayCellView, date: Date, cellState: CellState) {
        let myCustomCell = cell as! CalendarDateCellView
        
        // Setup Cell text
        myCustomCell.dayLabel.text = cellState.text
        
        handleCellSelection(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
        handleCellSelection(view: cell, cellState: cellState)
        if cellState.dateBelongsTo != .thisMonth {
            calendarView.scrollToDate(cellState.date)
        }
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
        handleCellSelection(view: cell, cellState: cellState)
    }
    
    func handleCellSelection(view: JTAppleDayCellView?, cellState: CellState) {
        guard let myCustomCell = view as? CalendarDateCellView  else {
            return
        }
        if workingDays.index(of: cellState.column() + 1) == nil {
            myCustomCell.backgroundColor = Colors.unavailableDate
        } else {
            if cellState.isSelected {
                myCustomCell.backgroundColor = Colors.accent
            } else {
                if cellState.dateBelongsTo == .thisMonth {
                    myCustomCell.backgroundColor = UIColor.white
                } else {
                    myCustomCell.backgroundColor = Colors.pastDate
                }
            }
        }
        
        // TableView reload
    }

    // TableView Delegates

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let viewModel = calendarViewModel {
            return viewModel.events.count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellReuseIdentifier.CalendarDayCell.rawValue) as? CalendarDayTableViewCell
        return cell!
    }


}
