//
//  MFindViewController.swift
//  MAlgorithmDemo
//
//  Created by mal on 2019/10/30.
//  Copyright © 2019 mal. All rights reserved.
//

import UIKit

class MFindViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let array = MFindViewController.mcreateArrayWithNums(nums: 10, maxNum: 100)
        print("排序前array = \(array)")
        let sortArray = MFindViewController.mSortNumArray(array: array)
        print("排序后array = \(sortArray)")
    }

    static func mcreateArrayWithNums(nums: Int, maxNum: Int) -> [Int]{
        
        var array = [Int]()
        if maxNum < nums {
            
            print("无法生成指定数组 个数：\(nums) 最大值：\(maxNum)")
            return array
        }
        while array.count < nums {
            
            let num = Int(arc4random()) % maxNum + 1
            if array.contains(num) == false {
                
                array.append(num)
            }
        }
        return array
    }
    
    static func mSortNumArray(array: [Int]) -> [Int] {
        
        let count = array.count
        guard count > 0 else {
            return array
        }
        var sortArray = array
        for i in 0...(count - 2) {
            
            var isContinue = false
            for j in 0...(count - i - 2) {
                
                let num1 = sortArray[j]
                let num2 = sortArray[j + 1]
                if num1 > num2 {
                    
                    isContinue = true
                    sortArray[j + 1] = num1
                    sortArray[j] = num2
                }
            }
            if isContinue == false {
                break
            }
        }
        return sortArray
    }
}
