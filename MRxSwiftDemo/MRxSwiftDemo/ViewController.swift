//
//  ViewController.swift
//  MRxSwiftDemo
//
//  Created by mal on 2020/6/10.
//  Copyright © 2020 mal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var testTF: UITextField!
    @IBOutlet weak var testBtn: UIButton!
    
    let disposebag = DisposeBag()
    var timerDisposeBag: DisposeBag? = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        test()
        
        testTimer()
    }
    
    func test() {
        testBtn.rx.tap.subscribe(onNext: {
            print("testbtn click")
        }).disposed(by: disposebag)
        
        testTF.rx.text.orEmpty.changed.subscribe { (text) in
            print("testTF输入内容：\(text)")
        }.disposed(by: disposebag)
        
        testTF.rx.text.bind(to: testBtn.rx.title()).disposed(by: disposebag)
    }
    
    func testTimer() {
        let timer = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
        timer.subscribe(onNext: { (num) in
            print("hello word \(num)")
        }).disposed(by: timerDisposeBag!)
        
//        let array = ["LG_Cooci","LG_Kody"]
//        Observable<[String]>.just(array)
//            .subscribe { (event) in
//                print(event)
//            }.disposed(by: disposebag)
//
//        _ = Observable<[String]>.just(array).subscribe(onNext: { (number) in
//            print("订阅:",number)
//        }, onError: { (error) in
//            print("error:",error)
//        }, onCompleted: {
//            print("完成回调")
//        }) {
//            print("释放回调")
//        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        testTF.text = ""
        timerDisposeBag = nil
        view.endEditing(true)
    }
}


