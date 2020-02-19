//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by wtildestar on 19/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import Foundation

extension Date {
    func convertMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
