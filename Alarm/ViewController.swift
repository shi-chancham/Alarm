//
//  ViewController.swift
//  Alarm
//
//  Created by 高橋詩穂 on 2016/11/05.
//  Copyright © 2016年 Shiho Takahashi. All rights reserved.
//

import UIKit
import CustomizableActionSheet

class ViewController: UIViewController, SampleViewDelegate {
    
    var dateLabel = UILabel()
    var actionSheet: CustomizableActionSheet?
    @IBOutlet var hourView: UIView!
    @IBOutlet var minuteView: UIView!
    @IBOutlet var secondView: UIView!
    
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
    
    @IBAction func buttonShowWasTapped() {
        var items = [CustomizableActionSheetItem]()
        
        // First view
        if let sampleView = UINib(nibName: "SampleView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as? SampleView {
            sampleView.delegate = self
            let sampleViewItem = CustomizableActionSheetItem()
            sampleViewItem.type = .view
            sampleViewItem.view = sampleView
            sampleViewItem.height = 100
            items.append(sampleViewItem)
        }
        
        // Second button
        let clearItem = CustomizableActionSheetItem()
        clearItem.type = .button
        clearItem.label = "Clear color"
        clearItem.backgroundColor = UIColor(red: 1, green: 0.41, blue: 0.38, alpha: 1)
        clearItem.textColor = UIColor.white
        clearItem.selectAction = { (actionSheet: CustomizableActionSheet) -> Void in
            self.view.backgroundColor = UIColor.white
            actionSheet.dismiss()
        }
        items.append(clearItem)
        
        // Third button
        let closeItem = CustomizableActionSheetItem()
        closeItem.type = .button
        closeItem.label = "Close"
        closeItem.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        closeItem.selectAction = { (actionSheet: CustomizableActionSheet) -> Void in
            actionSheet.dismiss()
        }
        items.append(closeItem)
        
        let actionSheet = CustomizableActionSheet()
        self.actionSheet = actionSheet
        actionSheet.showInView(self.view, items: items)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setColor(color: UIColor) {
        if let actionSheet = self.actionSheet {
            actionSheet.dismiss()
        }
        self.view.backgroundColor = color
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
        let rotateMin = CGAffineTransform(rotationAngle: CGFloat(2 * M_PI * Double(dateComps.minute!)) / CGFloat(60))
        let rotateSec = CGAffineTransform(rotationAngle: CGFloat(2 * M_PI * Double(dateComps.second!)) / CGFloat(60))
        
        UIView.animate(withDuration: 0.1) {
            self.hourView.transform = rotateHour
            self.minuteView.transform = rotateMin
            self.secondView.transform = rotateSec
        }
    }
    
}

