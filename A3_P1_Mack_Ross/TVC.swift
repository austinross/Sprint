//
//  TVC.swift
//  A3_P1_Mack_Ross
//
//  Created by Austin Ross on 10/2/19.
//  Copyright © 2019 Mack Ross. All rights reserved.
//

import UIKit

class TVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var laps: [Lap] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        navigationController?.isNavigationBarHidden = false
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else {
            return laps.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0) {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Fastest Lap: \(fastestLap())"
            case 1:
                cell.textLabel?.text = "Slowest Lap: \(slowestLap())"
            default:
                cell.textLabel?.text = "Average Lap: \(averageLap())"
            }
            return cell
        } else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
            cell.textLabel?.text = "Lap \(indexPath.row+1): \(laps[indexPath.row].getTimeString())"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Overall Stats"
        }
        else {
            return "Lap-wise Stats"
        }
    }
    
    func fastestLap() -> String {
        var fastest = laps[0]
        
        for i in 1..<laps.count {
            if laps[i].minutes < fastest.minutes {
                fastest = laps[i]
                continue
            }
            else if laps[i].minutes == fastest.minutes {
                if laps[i].seconds < fastest.seconds {
                    fastest = laps[i]
                    continue
                }
                else if laps[i].seconds == fastest.seconds {
                    if laps[i].deciseconds < fastest.deciseconds {
                        fastest = laps[i]
                        continue
                    }
                }
            }
        }
        
        return fastest.getTimeString()
    }
    
    func slowestLap() -> String {
        var slowest = laps[0]
        
        for i in 1..<laps.count {
            if laps[i].minutes > slowest.minutes {
                slowest = laps[i]
                continue
            }
            else if laps[i].minutes == slowest.minutes {
                if laps[i].seconds > slowest.seconds {
                    slowest = laps[i]
                    continue
                }
                else if laps[i].seconds == slowest.seconds {
                    if laps[i].deciseconds > slowest.deciseconds {
                        slowest = laps[i]
                        continue
                    }
                }
            }
        }
        
        return slowest.getTimeString()
    }
    
    func averageLap() -> String{
        var average: Double = 0.0
        
        for lap in laps {
            average += Double(".\(lap.deciseconds)")!
            average += Double(lap.seconds)
            average += Double(lap.minutes * 60)
        }
        average /= Double(laps.count)
        
        return "\(formatTime(average))"
    }
    
    func formatTime(_ time: Double) -> String {
        let minutes = Int(time) / 60 % 60
        var seconds = Double(Int(time) % 60)
        var deciseconds = time - Double(minutes) - Double(seconds)
        deciseconds = Double(round(10*deciseconds)/10)
        seconds = seconds + deciseconds
         
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        
        return minutesString+":"+secondsString
    }
    
}
