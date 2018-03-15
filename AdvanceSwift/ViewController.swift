//
//  ViewController.swift
//  AdvanceSwift
//
//  Created by EastElsoft on 2018/2/6.
//  Copyright © 2018年 AnatoleZho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 数组可变性
        // Swift 中数组默认推断类型为 Array
        // Array 是值类型，具有值语义： 当创建一个新的数组变量并且将一个已经存在的数组赋值给它时，这个数组的内容会被复制
        let x = [1, 2, 3]
        var y = x
        y.append(4)
        print("Swift mutable Arr y:", y)
        print("Swift immutable Arr x:", x)
        
        let a = NSMutableArray.init(array: [1, 2, 3])
        // 虽然 b 拥有的是一个不可变的 NSArray，但是它的引用特性并不能保证这个数组不会被改变，事实上它依然能够被 a 影响并改变
        let b: NSArray = a
        a.insert(4, at: 3)
        print("OC immutable Arr b", b)
        
        // 正确的方式是：在赋值时，先手动进行复制
        let d = a.copy() as! NSArray
        a.insert(5, at: 4)
        print("OC immutable Arr d:", d)
        /*
         创建如此多的复制可能会导致性能问题，不过实际上，Swift 标准库中的所有集合类型都使用了 “写时复制” 这一技术，它能够保证只在必要的时候对数据进行复制。在例子中，直到 y.append 被调用之前， x, y 都将共享内部的存储。
         */
        
        
        // 数组可选性
        // 迭代数组
        let arr = [1, 2, 3, 4, 5, 6]
        for _ in arr {
            
        }
        
        // 迭代除第一个元素以外的数组其余部分
        for _ in arr.dropFirst() {
            
        }
        
        // 迭代除最后 5 个元素以外的数组其余部分
        for _ in arr.dropLast(5) {
            
        }
        
        // 列举数组中的元素和对应下标 enumerated 函数
        for (num, element) in arr.enumerated() {
            _ = num * element
        }
        
        // 寻找指定元素的位置 index 函数
        let idx = arr.index {
             $0 == 7 ? true : false
        }
        print("指定元素的位置: ", idx ?? "数组中没找到指定元素")
        
        // 对数组中元素进行变形 map 函数
        // 如：计算整数数组中元素的平方
       let transformArr = arr.map { $0 * $0 }
        print("数组中元素变形:", transformArr)

        // 筛选符合某个标准的元素 filter 函数
        let filterArr = arr.filter { $0 > 4 }
        print("筛选符合 大于 4 的元素:", filterArr)
        
        // 使用函数将行为参数化
        /**
         在一个逆序数组中寻找第一个满足特定条件的元素
         */
        let names = ["Paula", "Elena", "Zoe"]

        var lastNameEndingInA: String?
        for name in names.reversed() where name.hasSuffix("a") {
            lastNameEndingInA = name
            break
        }
        print(lastNameEndingInA ?? "")
        
        // 考虑为 Sequence 添加一个小扩展 将上述逻辑封装到 last(where:) 方法中
        let match = names.last { $0.hasSuffix("a") }
        print(match ?? "")

        // 在元素没有被找到的情况下提早结束代码
        guard names.last(where: {$0.hasSuffix("a")}) != nil else {
            return
        }
        print(match ?? "")
   
        // 可变和带有状态的闭包
        /**
         闭包是指可以捕获自身作用域之外的变量的函数
         闭包结合高阶函数将成为强大的工具
         */
        let accumulateArr = [1, 2, 3, 4, 5].accumulate(0, +)
        print("accumulateArr:",accumulateArr)
        
        
        // Filter
        print("Filter even num: ",arr.filter({ (num) -> Bool in
            return num % 2 == 0
        }))
        
        print("Filter even num: ", arr.filter { $0 % 2 == 0 })
        
        // 通过组合使用 map 和 filter，可以在不引用中间数组完成很多数组操作
        print("Map and filter: ", arr.map {$0 * $0}.filter { $0 % 2 == 0})
        
        // 性能小提示
        print("filter Result: ", arr.filter {$0 > 4}.count > 0)
        /**
         filter 会创建一个新的数组，并且会对数组中的每一个元素都进行操作。然而在上面的代码中这显然是不必要的。上面代码仅仅检查是否至少有一个元素满足条件，在这种情形下，使用 contains 更为合适
         这种做法会比原来快的多，主要因为： contains 不会为了计数而创建一整个新的数组，并且一旦匹配了第一个元素，它将会提前退出。一般来说，只有在需要所有结果是才回去选择 filter
         */
         print("contains Result: ", arr.contains {$0 > 4})
        
        // 想用 contains 完成一些操作，但写出来的代码看起来很糟糕
        // 如： 检查一个序列中的所有元素是否全部都满足某个条件 可以使用 ！sequence.contains {!condition}, 封装一下
        let evenNums = arr.filter { $0 % 2 == 0 }
        print("Contains conditional result: ", evenNums.all {$0 % 2 == 0})
        
        
        
        print([1, 2, 3, 12, 1, 3, 4, 5, 6].unique())
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

