//
//  CalendarDateCellView.swift
//  Regease
//
//  Created by Karol Stępień on 29.11.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import JTAppleCalendar

class CalendarDateCellView: JTAppleDayCellView {
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet weak var selectionView: UIView!
    @IBOutlet weak var unavailableView: UIView!
}
