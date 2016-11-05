//
//  ViewController.swift
//  Alarm
//
//  Created by 高橋詩穂 on 2016/11/05.
//  Copyright © 2016年 Shiho Takahashi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var dateLabel = UILabel()
    @IBOutlet var hourImageView: UIImageView!
    @IBOutlet var minuteImageView: UIImageView!
    @IBOutlet var secondImageView: UIImageView!
    
    // 日時フォーマット
    var dateFormatter: DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return formatter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        dateLabel.frame = view.bounds
        dateLabel.textAlignment = .center
        view.addSubview(dateLabel)
        
        // 初回
        updateDateLabel()
        
        // 一定間隔で実行
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateDateLabel), userInfo: nil, repeats: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // 日時表示ラベル更新メソッド
    func updateDateLabel(){
        let now = Date()
        dateLabel.text = dateFormatter.string(from: now)
        
        let date = Date()
        
        let calendar = Calendar.current
        let dateComps: DateComponents = calendar.dateComponents([.hour, .minute, .second], from: date)
        
        let minute = Double(60 * dateComps.hour! + dateComps.minute!)
        let rotateHour = CGAffineTransform(rotationAngle: CGFloat(2 * M_PI * minute) / CGFloat(60 * 12))
        let rotateMin = CGAffineTransform(rotationAngle: CGFloat(2 * M_PI * Double(dateComps.minute!)) / CGFloat(6))
        let rotateSec = CGAffineTransform(rotationAngle: CGFloat(2 * M_PI * Double(dateComps.second!)) / CGFloat(60))
        
        UIView.animate(withDuration: 0.1) {
            self.hourImageView.transform = rotateHour
            self.minuteImageView.transform = rotateMin
            self.secondImageView.transform = rotateSec
//            self.hourImageView.layer.anchorPoint = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/2)
//            self.minuteImageView.layer.anchorPoint = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/2)
//            self.secondImageView.layer.anchorPoint = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/2)
            
        }
    }
    
}

