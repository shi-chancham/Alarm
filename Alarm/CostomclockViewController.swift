//
//  CostomclockViewController.swift
//  Alarm
//
//  Created by 高橋詩穂 on 2017/01/28.
//  Copyright © 2017年 Shiho Takahashi. All rights reserved.
//

import UIKit

class CostomclockViewController: UIViewController {
    
    @IBOutlet var clockLabel: UILabel!
    @IBOutlet var choosePicker: UIDatePicker!
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ud = UserDefaults.standard
        let udId = ud.object(forKey: "first")
        
        if udId == nil {
            //遷移
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextView = storyboard.instantiateInitialViewController()
            present(nextView!, animated: true, completion: nil)
            ud.set(true, forKey: "first")
        } else {
            //なにもしない
        }
        
        // 起動した時点の時刻をmyLabelに反映
        clockLabel.text = getNowTime()
        // 時間管理してくれる
         timer = Timer.scheduledTimer(timeInterval: 1/60, target: self, selector: #selector(DigitalViewController.update), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private var tempTime: String = "00:00"
    private var setTime: String = "00:00"
    
    @IBAction func myDPfunc(sender: AnyObject) {
        // test print
        print("test: myDP moved!")
        // DPの値を成形
        let format = DateFormatter()
        format.dateFormat = "HH:mm"
        // 一時的にDPの値を保持
        tempTime = format.string(from: choosePicker.date)
    }
    
    @IBAction func myButtonfunc(sender: AnyObject) {
        // アラームをセット
        setTime = tempTime
        // test print
        print("test: myButton Pushed!")
    }
    
    func getNowTime()-> String {
        // 現在時刻を取得
        let nowTime: NSDate = NSDate()
        // 成形する
        let format = DateFormatter()
        format.dateFormat = "HH:mm"
        let nowTimeStr = format.string(from: nowTime as Date)
        // 成形した時刻を文字列として返す
        return nowTimeStr
    }
    
    func update() {
        // 現在時刻を取得
        let str = getNowTime()
        // Labelに反映
        clockLabel.text = str
        // アラーム鳴らすか判断
        myAlarm(str: str)
    }
    
    func myAlarm(str: String) {
        if str == setTime{
            alert()
        }
    }
    
    // アラートの表示
    func alert() {
        let myAlert = UIAlertController(title: "alert", message: "ring ding", preferredStyle: .alert)
        let myAction = UIAlertAction(title: "dong", style: .default) {
            action in print("foo!!")
            self.timer.invalidate()
        }
        myAlert.addAction(myAction)
        present(myAlert, animated: true, completion: nil)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
