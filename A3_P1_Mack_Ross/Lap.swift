//
//  Lap.swift
//  A3_P1_Mack_Ross
//
//  Created by Austin Ross on 10/2/19.
//  Copyright © 2019 Mack Ross. All rights reserved.
//

class Lap {
    var deciseconds: Int
    var seconds: Int
    var minutes: Int
    
    public init() {
        self.minutes = 0
        self.seconds = 0
        self.deciseconds = 0
    }
    
    public func increment() -> String{
        deciseconds += 1
        if deciseconds == 10 {
            seconds += 1
            deciseconds = 0
        }
        if seconds == 60 {
            minutes += 1
            seconds = 0
        }
        
        let decisecondsString = "\(deciseconds)"
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        
        return minutesString+":"+secondsString+"."+decisecondsString
    }
    
    public func getTimeString() -> String {
        let decisecondsString = "\(deciseconds)"
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        
        return minutesString+":"+secondsString+"."+decisecondsString
    }
    
}
