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
        //self.binary_seary_test()
        let array = MFindViewController.mcreateArrayWithNums(nums: 20, maxNum: 30)
        print("需要排序的数组是：\(array)")
        let sortArray = self.mquickSort(array: array)
        print("排序后的数组是：\(sortArray)")
    }
    
    //MARK: ------------测试小例子
    //MARK: 二分查找测试
    func binary_seary_test() {
        
        DispatchQueue.global().async {
            
            let nums:UInt32 = 20
            let findIndex = Int(arc4random() % nums) + 1
            var array = [Int]()
            for i in 0...nums {
                array.append(Int(i))
                if i == findIndex {
                    array.append(Int(i))
                    array.append(Int(i))
                }
            }
            print("要查找的数组是：\(array)")
            let findNum = array[findIndex]
            print("要查找的数是：\(findNum) 正确的index是：\(findIndex)")
            MHelp.m_startTime()
            let index = MFindViewController.m2fenfeidigui(array: array, target: findNum)
            print("查找到的index是：\(index ?? [-1])")
            MHelp.m_printCostTime()
        }
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
    
    //MARK: 快速排序n * log2n（n是每次根据基准点将数组分为两部分时需要遍历整个数组 log是指每次都将数组折半折 /2 /2 折对数次就可将数组变为<=1个元素）
    //如果不凑巧每次选中的都是最大/最小的值 那就需要执行算法n次；所以最复杂的情况时间复杂度为n * n
    func mquickSort(array: [Int]) -> [Int] {
        if array.count < 2 {
            return array
        }
        let baseNum = array[0]
        var lowArray = [Int]()
        var highArray = [Int]()
        for i in 1...(array.count - 1) {
            let num = array[i]
            if num < baseNum {
                lowArray.append(num)
            } else {
                highArray.append(num)
            }
        }
        return mquickSort(array: lowArray) + [baseNum] + mquickSort(array: highArray)
    }
        
    //MARK: ---------------------查找算法
    //MARK: 二分查找递归实现（性能要比非递归差很多）
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
    
    //MARK: 二分查找非递归实现
    static func m2fenfeidigui(array: [Int], target: Int) -> [Int]? {
        
        var low = 0
        var high = array.count - 1
        while low <= high {
            let mid = (low + high) / 2
            let guess = array[mid]
            if guess == target {
                return self.m2fenSameNumHandle(array: array, target: target, rightIndex: mid)
            }
            if guess > target {
                high = mid - 1
            } else {
              low = mid + 1
            }
        }
        return nil
    }
    
//解决二分查找数组里有相同元素查找不全的问题（因为二分查找要求数组是有序的，所以相同元素是紧挨在一起的，拿到一个正确的index左右遍历一下就可以了）
    static func m2fenSameNumHandle(array: [Int], target: Int, rightIndex: Int) -> [Int] {
        
        var resultArray = [Int]()
        resultArray.append(rightIndex)
        let maxIndex = array.count - 1
        var countIndex = rightIndex + 1
        let minIndex = 0
        while countIndex <= maxIndex {
            if target == array[countIndex] {
                resultArray.append(countIndex)
                countIndex = countIndex + 1
            } else{
                break
            }
        }
        countIndex = rightIndex - 1
        while countIndex >= minIndex {
            if target == array[countIndex] {
                resultArray.append(countIndex)
                countIndex = countIndex - 1
            } else{
                break
            }
        }
        return resultArray
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
        return nil
    }
}
