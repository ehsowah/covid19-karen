//
//  Extension.swift
//  Covid19
//
//  Created by sowah on 4/6/20.
//  Copyright © 2020 sowah. All rights reserved.
//

import Foundation

extension String {
    func countryNameToCodeConvert(name: String) -> String {
        
        for i in countryCodes {
            if name == i.value {
                return i.key.lowercased()
            }
        }
        return "noFlag"
    }
    
    func dateFormatter(date: String) -> String {
        var formattedDate = ""
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM d, yyyy"

        if let date = dateFormatterGet.date(from: date) {
            formattedDate = "\(dateFormatterPrint.string(from: date))"
        } else {
           print("There was an error decoding the string")
        }
        
        return formattedDate
    }
    
    func timeFormatter(date: String) -> String {
        var formattedDate = ""
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "h:mm a"

        if let date = dateFormatterGet.date(from: date) {
            formattedDate = "\(dateFormatterPrint.string(from: date))"
        } else {
           print("There was an error decoding the string")
        }
        
        return formattedDate
    }
    
}
