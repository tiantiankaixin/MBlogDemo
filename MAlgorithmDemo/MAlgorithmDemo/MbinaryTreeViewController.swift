//
//  MbinaryTreeViewController.swift
//  MAlgorithmDemo
//
//  Created by maliang on 2020/8/5.
//  Copyright © 2020 mal. All rights reserved.
//

import UIKit

class MBinaryTree: CustomStringConvertible {
    var leftNode: MBinaryTree? = nil
    var rightNode: MBinaryTree? = nil
    var nodeValue: Int = 0
    
    convenience init(value: Int) {
        self.init()
        self.nodeValue = value
    }
    
    func addChildNodeWith(leftNodeValue: Int, rightNodeValue: Int) {
        leftNode = MBinaryTree(value: leftNodeValue)
        rightNode = MBinaryTree(value: rightNodeValue)
    }
    
    var description: String {
        return "\(nodeValue)"
    }
}


class MbinaryTreeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let binaryTree = createBinary() {
            breadthFirstSearch(binaryTree: binaryTree)
        }
    }
    
    func createBinary() -> MBinaryTree? {
        let head: MBinaryTree = MBinaryTree(value: 0)
        head.addChildNodeWith(leftNodeValue: 1, rightNodeValue: 2)
        head.leftNode?.addChildNodeWith(leftNodeValue: 3, rightNodeValue: 4)
        head.rightNode?.addChildNodeWith(leftNodeValue: 5, rightNodeValue: 6)
        return head
    }
    
    func breadthFirstSearch(binaryTree: MBinaryTree) {
        var nodeArray = [MBinaryTree]()
        nodeArray.append(binaryTree)
        while nodeArray.isEmpty == false {
            if let head = nodeArray.first {
                print(head)
                nodeArray.remove(at: 0)
                if let leftNode = head.leftNode {
                    nodeArray.append(leftNode)
                }
                if let rightNode = head.rightNode {
                    nodeArray.append(rightNode)
                }
            }
        }
    }
    
    func depthFirstSearch(binaryTree: MBinaryTree) {
        var nodeArray = [MBinaryTree]()
        nodeArray.append(binaryTree)
        while nodeArray.isEmpty == false {
            if let head = nodeArray.first {
                print(head)
                nodeArray.remove(at: 0)
                if let leftNode = head.leftNode {
                    nodeArray.append(leftNode)
                }
                if let rightNode = head.rightNode {
                    nodeArray.append(rightNode)
                }
            }
        }
    }
}
