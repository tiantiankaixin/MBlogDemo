//
//  MDiguiViewController.swift
//  MAlgorithmDemo
//
//  Created by mal on 2019/10/31.
//  Copyright © 2019 mal. All rights reserved.
//

import UIKit

class MDiguiViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.sumdigui(nums: [1, 3 ,5]))
    }
    
    func sumdigui(nums: [Int]) -> Int {
        guard nums.count > 0 else {
            return 0
        }
        if nums.count == 1 {
            return nums[0]
        } else {
            var newNums = nums
            let num = newNums[newNums.count - 1]
            newNums.remove(at: newNums.count - 1)
            return num + sumdigui(nums: newNums)
        }
    }
}
