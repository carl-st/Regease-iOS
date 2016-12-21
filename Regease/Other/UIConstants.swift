//
//  UIConstants.swift
//  Regease
//
//  Created by Karol Stępień on 28.11.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import Foundation

public enum NavigationControllerStoryboardIdentifier : String {
    case LoginNavigationController
}

public enum SegueIdentifier : String {
    case showDetails
}

public enum StoryboardNames : String {
    case Login
    case Main
}

public enum ViewControllerStoryboardIdentifier : String {
    case MainTabBarController
}

public enum TableViewCellReuseIdentifier : String {
    case CalendarDayCell
    case DashboardCell
    case DashboardWelcomeCell
}
