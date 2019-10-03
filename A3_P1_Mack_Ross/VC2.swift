//
//  VC2.swift
//  A3_P1_Mack_Ross
//
//  Created by Austin Ross on 10/2/19.
//  Copyright © 2019 Mack Ross. All rights reserved.
//

import UIKit

class VC2: UIViewController {

    // MARK: - Variables
    @IBOutlet weak var currentLapLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var lapsLabel: UILabel!
    
    @IBOutlet weak var controlButton: UIButton!
    @IBOutlet weak var newLapButton: UIButton!
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var resetButton: UIBarButtonItem!
    @IBOutlet weak var statsButton: UIBarButtonItem!
    
    var timer = Timer()
    var isTracking = false
    var numLaps = 1
    var totalLap = Lap()
    var currentLap = Lap()
    var laps: [Lap] = []
    
    
    // MARK: - View functions
    override func viewDidLoad() {
        super.viewDidLoad()
        statsButton.isEnabled = false
        resetButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Timer and Button functions
    @IBAction func controlTracking(sender: AnyObject) {
        if isTracking {
            isTracking = false
            newLapButton.isEnabled = false
            statsButton.isEnabled = true
            controlButton.setTitle("Start", for: .normal)
            controlButton.setTitleColor(.green, for: .normal)
            
            timer.invalidate()
        } else {
            isTracking = true
            newLapButton.isEnabled = true
            statsButton.isEnabled = false
            resetButton.isEnabled = true
            controlButton.setTitle("Stop", for: .normal)
            controlButton.setTitleColor(.red, for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        }
    }
    
    @objc func updateTime() {
        totalTimeLabel.text = totalLap.increment()
        currentLapLabel.text = currentLap.increment()
    }
    
    @IBAction func addLap() {
        laps.append(currentLap)
        currentLap = Lap()
        numLaps += 1
        lapsLabel.text = "\(numLaps)"
    }
    
    @IBAction func reset() {
        let alert = UIAlertController(title: "Warning", message: "Are you sure you want to lose all progress?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.totalLap = Lap()
            self.currentLap = Lap()
            self.laps = []
            self.numLaps = 1
            self.lapsLabel.text = "1"
            self.currentLapLabel.text = "00:00.0"
            self.totalTimeLabel.text = "00:00.0"
            self.isTracking = false
            self.newLapButton.isEnabled = false
            self.statsButton.isEnabled = false
            self.resetButton.isEnabled = false
            self.controlButton.setTitle("Start", for: .normal)
            self.controlButton.setTitleColor(.green, for: .normal)
            self.timer.invalidate()
            }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func back() {
        let alert = UIAlertController(title: "Warning", message: "Are you sure you want to lose all progress?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.navigationController?.popViewController(animated: true)
            }))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var tempLaps = laps
        tempLaps.append(currentLap)
        let destination = segue.destination as! TVC
        destination.laps = tempLaps
    }


}
