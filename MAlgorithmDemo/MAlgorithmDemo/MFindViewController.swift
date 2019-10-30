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
        let nums: UInt32 = 30
        let array = MFindViewController.mcreateArrayWithNums(nums: nums, maxNum: 100)
        print("排序前array = \(array)")
        let sortArray = MFindViewController.mSortNumArray(array: array)
        print("排序后array = \(sortArray)")
        let findIndex = Int(arc4random() % nums)
        let findNum = sortArray[findIndex]
        print("要查找的数是：\(findNum) 正确的index是：\(findIndex)")
        let index = MFindViewController.m2fenchazhao(array: sortArray, target: findNum)
        print("查找到的index是：\(index ?? -1)")
    }

    //MARK: ---------------------排序算法
    //MARK: 冒泡排序
    static func mSortNumArray(array: [Int]) -> [Int] {
        
        let count = array.count
        guard count > 1 else {
            print("\(array)\n不需要排序")
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
    
    //MARK: 选择排序
    static func mSelectSortNumArray(array: [Int]) -> [Int] {
        
        let count = array.count
        guard count > 1 else {
            print("\(array)\n不需要排序")
            return array
        }
        var sortArray = array
        for i in 0...(count - 2) {
            
            var maxIndex = 0
            for j in 0...(count - i - 1) {
                
                let jNum = sortArray[j]
                if jNum > sortArray[maxIndex] {
                    maxIndex = j
                }
            }
            let num1 = sortArray[maxIndex]
            let num2 = sortArray[count - i - 1]
            sortArray[maxIndex] = num2
            sortArray[count - i - 1] = num1
        }
        return sortArray
    }
    
    //MARK: ---------------------查找算法
    //MARK: 二分查找
    static func m2fenchazhao(array: [Int], target: Int) -> Int? {
        
        let count = array.count
        if count < 3 {
            
            for (idx, obj) in array.enumerated() {
                
                if obj == target {
                    
                    return idx
                }
            }
        }
        let midIndex = count / 2 + (count % 2) - 1
        let midNum = array[midIndex]
        if midNum == target {
            
            return midIndex
            
        } else if midNum > target {
            
            if let newArray = self.mRangeArray(array: array, fromIndx: 0, toIndex: midIndex - 1) {
             
                return self.m2fenchazhao(array: newArray, target: target)
            }
            
        } else {
            
            if let newArray = self.mRangeArray(array: array, fromIndx: midIndex + 1, toIndex: count - 1) {
                
                if let index = self.m2fenchazhao(array: newArray, target: target) {
                    
                    return index + midIndex + 1
                }
            }
        }
        return nil
    }
    
    //MARK: --------------- help
    
    /// 随机整形数组生成
    /// - Parameter nums: 数组元素个数
    /// - Parameter maxNum: 元素最大值
    static func mcreateArrayWithNums(nums: UInt32, maxNum: Int) -> [Int]{
           
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
    
    /// 截取数组
    /// - Parameter array: 源数组
    /// - Parameter fromIndx: 截取起始位置
    /// - Parameter toIndex: 截取终止位置
    static func mRangeArray<T>(array: [T], fromIndx: Int, toIndex: Int) -> [T]? {
        
        var newArray = [T]()
        if fromIndx < toIndex && toIndex < array.count {
            
            for i in fromIndx...toIndex {
                
                newArray.append(array[i])
            }
            return newArray
        }
        return nil;
    }
}