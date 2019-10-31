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
        let nums:UInt32 = 100
        let findIndex = Int(arc4random() % nums) + 1
        var array = [Int]()
        for i in 0...nums {
            array.append(Int(i))
        }
        //print("要查找的数组是：\(array)")
        let findNum = array[findIndex]
        print("要查找的数是：\(findNum) 正确的index是：\(findIndex)")
        let index = MFindViewController.m2fenfeidigui(array: array, target: findNum)
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
        
        return self.m2fenchazhao1(array: array, target: target, lowIndex: 0, highIndex: array.count - 1)
    }
    
    static func m2fenchazhao1(array: [Int], target: Int, lowIndex: Int, highIndex: Int) -> Int? {
        
        let count = array.count
        if lowIndex > highIndex || highIndex > count - 1 {
            print("输入参数有误")
            return nil
        }
        if count < 3 {
            
            for (idx, obj) in array.enumerated() {
                
                if obj == target {
                    
                    return idx
                }
            }
        }
        let midIndex = (lowIndex + highIndex) / 2;
        //print("lowIndex:\(lowIndex) highIndex:\(highIndex) midIndex:\(midIndex)")
        let midNum = array[midIndex]
        if midNum == target {
            
            return midIndex
            
        } else if midNum > target {
            
            return self.m2fenchazhao1(array: array, target: target, lowIndex: lowIndex, highIndex: midIndex - 1)
            
        } else {
            
            return self.m2fenchazhao1(array: array, target: target, lowIndex: midIndex + 1, highIndex: highIndex)
        }
    }
    
    static func m2fenfeidigui(array: [Int], target: Int) -> Int? {
        
        var low = 0
        var high = array.count
        while low <= high {
            let mid = (low + high) / 2
            let guess = array[mid]
            if guess == target {
                return mid
            }
            if guess > target {
                high = mid - 1
            } else {
              low = mid + 1
            }
        }
        return nil
    }
    
    //MARK: --------------- help
    /// 随机整形数组生成（无重复 数量过多的时候有性能问题）
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
