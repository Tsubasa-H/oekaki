//
//  ViewController.swift
//  oekaki2
//
//  Created by 服部翼 on 2019/04/07.
//  Copyright © 2019 服部翼. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var bezierPath: UIBezierPath!//線を描写するのに必要なもの？
    var lastDrawImage: UIImage?
    var lineColor = UIColor.black
    var lineWidth_bar: CGFloat = 10.0

    
    @IBOutlet weak var view_canvas: UIImageView!
    @IBOutlet weak var color_segment: UISegmentedControl!
    @IBOutlet weak var line_width: UISegmentedControl!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let width = self.view.frame.width
        let height = self.view.frame.height
        
        
        //キャンバスを設置
        view_canvas.frame = CGRect(x:0, y:0, width:width, height:height)
        view_canvas.backgroundColor = UIColor.clear
        self.view.addSubview(view_canvas)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //指が触れた時に呼び出されるメソッド
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchEvent = touches.first! //タッチ時のイベントを取得する
        let currentPoint:CGPoint = touchEvent.location(in: self.view_canvas) //現在の座標を取得する
        bezierPath = UIBezierPath() //bezierPathは曲線を扱うためのやつらしい?
        bezierPath.lineWidth = lineWidth_bar //線の太さ
        bezierPath.lineCapStyle = .butt //Swiftで円弧などを描画させる時に「UIBezierPath」というクラスを使用する、その中のプロパティに「lineCapStyle」がある。またlineCapStyleには3種類の変化をつけることができる。1.butt、2.round、3.square、の3種類。
        bezierPath.move(to: currentPoint) //始点を現在の位置に設定している
    }

    
    //ドラッグ中のイベント
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //もしもタッチ開始時にパスを初期化していない場合は処理を終了する。（なんとなくは分かるけど意味わからん）
        if bezierPath == nil {
            return
        }
        let touchEvent = touches.first!
        let currentPoint: CGPoint = touchEvent.location(in: self.view_canvas)
        bezierPath.addLine(to: currentPoint) //現在の座標を取得して、線を引いていく
        drawLine(path: bezierPath)
        
    
    }
    
    
    //指を離した時のイベント
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if bezierPath == nil {
            return
        }
        let touchEvent = touches.first!
        let currentPoint: CGPoint = touchEvent.location(in: self.view_canvas)
        bezierPath.addLine(to: currentPoint)
        drawLine(path: bezierPath)
        self.lastDrawImage = view_canvas.image //これまで描いた線を保存する
    }
    
    
    
    
    
    
    //描写処理
    func drawLine(path: UIBezierPath) {
        //UIGraphicsBeginImageContextで非表示の描画領域を生成する。ここに描画してから画面に表示させる。
        UIGraphicsBeginImageContext(view_canvas.frame.size)
        if let image = self.lastDrawImage {
            image.draw(at: CGPoint.zero)
        }
        
        
        lineColor.setStroke()
        path.stroke()
        self.view_canvas.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
    }
    
    
    
    
    //Trashボタンを押すと画面が消える
    @IBAction func Trash(_ sender: Any) {
        lastDrawImage = nil //こっちを消すとTrashボタンを押すと消えるが、指が触れると前に書いていたものが現れる。
        self.view_canvas.image = nil //こっちを消すとTrashボタンを押した時は消えず、次に新しく指が触れると消える。
        
        
    }
    
    
    
    
    @IBAction func Undo_button(_ sender: Any) {
        
}
    
  //segmentbuttonで色を変える
    @IBAction func Segment_Button(_ sender: Any) {
        switch color_segment.selectedSegmentIndex {
        case 0:
            lineColor = UIColor.black
        case 1 :
            lineColor = UIColor.red
        case 2 :
            lineColor = UIColor.blue
        case 3 :
            lineColor = UIColor.green
        case 4 :
            lineColor = UIColor.white
        default:
            lineColor = UIColor.black
        }
    }
    
    //segmentbuttonで線の太さを変える
    @IBAction func line(_ sender: Any) {
        switch line_width.selectedSegmentIndex {
        case 0:
            lineWidth_bar = 8.0
        case 1:
            lineWidth_bar = 16.0
        case 2:
            lineWidth_bar = 32.0
        default:
            lineWidth_bar = 10.0
        }
        
    }
    
        
    
   
    
}

