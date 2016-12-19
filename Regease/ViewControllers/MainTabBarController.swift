//
//  MainTabBarController.swift
//  Regease
//
//  Created by Karol Stępień on 29.11.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        CalendarServices.sharedInstance.getAppointments(completion: {_, _ -> Void in})
        CalendarServices.sharedInstance.getCalendar(completion: {_, _ -> Void in})
    }


}
