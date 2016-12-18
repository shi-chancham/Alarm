//
//  DigitalViewController.swift
//  Alarm
//
//  Created by 高橋詩穂 on 2016/12/18.
//  Copyright © 2016年 Shiho Takahashi. All rights reserved.
//

import UIKit

class DigitalViewController: UIViewController {
    
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var monthLabel: UILabel!
    @IBOutlet var daysLabel: UILabel!
    @IBOutlet var dayOfTheWeekLabel: UILabel!
    @IBOutlet var hourLabel: UILabel!
    @IBOutlet var minutesLabel: UILabel!
    @IBOutlet var secondLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nowTime()
        _ = Timer.scheduledTimer(timeInterval: 1/60, target: self, selector: #selector(DigitalViewController.update), userInfo: nil, repeats: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //NSTimerを利用して60分の1秒ごとに呼びたす。
    func update() {
        nowTime()
    }
    
    func nowTime(){
        let myDate: NSDate = NSDate()//現在時刻を取得
        let myCalendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        //カレンダーを取得

        let myComponetns = myCalendar.components([.year, .month, .day, .hour, .minute, .second, .weekday], from:myDate as Date)
        
        let weekdayStrings: Array = ["nil","Sun.","Mon.","Tues.","Wed.","Thurs.","Fri.","Sat.","Sun."]
        
        /*Storyboardに表示*/
        yearLabel.text = "\(myComponetns.year)"
        monthLabel.text = addZero(timeString: String(describing: myComponetns.month), timeNuber: myComponetns.month!)
        daysLabel.text = addZero(timeString: String(describing: myComponetns.day), timeNuber: myComponetns.day!)
        dayOfTheWeekLabel.text = "\(weekdayStrings[myComponetns.weekday!])"
        hourLabel.text = addZero(timeString: String(describing: myComponetns.hour), timeNuber: myComponetns.hour!)
        minutesLabel.text = addZero(timeString: String(describing: myComponetns.minute), timeNuber: myComponetns.minute!)
        secondLabel.text = addZero(timeString: String(describing: myComponetns.second), timeNuber: myComponetns.second!)
    }
    
    //1桁のものには0をつける。例えば1秒なら01秒に。
    func addZero(timeString: String, timeNuber: Int) -> String {
        if timeString.characters.count == 1 {
            return ("0\(timeNuber)")
        } else{
            return ("\(timeNuber)")
        }
    }
    
}
