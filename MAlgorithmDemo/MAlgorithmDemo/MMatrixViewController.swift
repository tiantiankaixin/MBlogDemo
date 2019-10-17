//
//  MMatrixViewController.swift
//  MAlgorithmDemo
//
//  Created by mal on 2019/10/17.
//  Copyright © 2019 mal. All rights reserved.
//

import UIKit

class MMatrixViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let matrix = CreateMatrix(rows: 3, cols: 4)
        print("创建的矩阵是：\(GetMatrixStr(matrix: matrix))")
        let rotateMatrix = MRotateMatrix(matrix: matrix)
        print("旋转后的矩阵是：\(GetMatrixStr(matrix: rotateMatrix))")
    }
    
    func CreateMatrix(rows:Int, cols:Int) -> Array<Array<Int>>{
           
           var array = Array<Array<Int>>()
           for _ in stride(from: 0, to: rows, by: 1){
               
               var subArray = Array<Int>()
               for _ in stride(from: 0, to: cols, by: 1){
                   
                   let number = Int(arc4random() % 100)
                   subArray.append(number)
               }
               array.append(subArray)
           }
           return array
       }
       
    func GetMatrixStr(matrix:Array<Array<Int>>) -> String{
           
           var str:String = ""
           if matrix.count > 0 {
               
               let colNum = matrix.first!.count
               for (row, rowArray) in matrix.enumerated(){
                   
                   if row == 0 {
                       
                       str.append("\n")
                   }
                   str.append(" ")
                   for (col, item) in rowArray.enumerated(){
                       
                       str.append(String.init(format: "%d", item))
                       if col == colNum - 1{//最后一列追加换行符
                           
                           str.append("\n")
                       }
                       else{//其它行追加分隔符（空格）
                           
                           str.append(" ")
                       }
                   }
               }
           }
           return String.init("\n{\(str)}\n")
       }
    
    func MRotateMatrix(matrix: [[Int]]) -> [[Int]]{
        
        //顺时针旋转90度
        //新的行 = 旧的列
        //新的列 = 行数 - 旧的行 - 1
        
        //如果是逆时针旋转90度
        //新的行 = 列数 - 旧的列 - 1
        //新的列 = 旧的行
        
        //创建一个同等大小的数组 将翻转前对应位置的值 挪动到翻转后对应位置
        let rows = matrix.count
        let cols = matrix.first!.count
        var newMatrix = CreateMatrix(rows: cols, cols: rows)
        for (row, rowArray) in matrix.enumerated(){
            
            for (col, item) in rowArray.enumerated(){
                
                let newRow = col
                let newCol = rows - row - 1
                newMatrix[newRow][newCol] = item
            }
        }
        return newMatrix
    }
}
