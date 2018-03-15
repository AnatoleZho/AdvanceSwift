//
//  ExtensionArray.swift
//  AdvanceSwift
//
//  Created by EastElsoft on 2018/2/6.
//  Copyright © 2018年 AnatoleZho. All rights reserved.
//

import Foundation

// 数组是一列相同类型的元素的有序的容器，对于其中的每个元素，我们都可以使用下标对其直接进行访问（又称随机访问）

// 数组变形
// Swift 中原生 map 函数的实现过程
extension Array {
    // 实际上 Swift 原生 map 函数的声明
   // public func map<T>(_ transform: (Element) throws -> T) rethrows -> [T]
    // 使用泛型声明
    // 使用函数将行为参数化
    func map<T>(_ transform: (Element) -> T) -> [T] {
        // 创建局部变量
        var result: [T] = []
        // 设置数组的存储空间
        result.reserveCapacity(count)
        for x in self {
            result.append(transform(x))
        }
        return result
    }
}

// 可变和带有状态的闭包
/**
 闭包是指可以捕获自身作用域之外的变量的函数
 闭包结合高阶函数将成为强大的工具
 */
extension Array {
    // 累加
    func accumulate<Result>(_ initialResult: Result, _ nextPartialResult: (Result , Element) -> Result) -> [Result] {
        // 创建中间变量来存储每一步的值
        var running = initialResult
        // 使用 map 来从这个中间值逐步创建结果数组
        return map({ next in
            running = nextPartialResult(running, next)
            return running
        })
    }
}

// filter 实现
extension Array {
    func filter(_ isIncluded: (Element) -> Bool) -> [Element] {
        var result: [Element] = []
        for x in self where isIncluded(x) {
            result.append(x)
        }
        return result
    }
}

extension Sequence {
    func last(where predicate: (Iterator.Element) -> Bool) -> Iterator.Element? {
        for element in reversed() where predicate(element) {
            return element
        }
        return nil
    }
}

extension Sequence {
    // 想用 contains 完成一些操作，但写出来的代码看起来很糟糕
    // 如： 检查一个序列中的所有元素是否全部都满足某个条件 可以使用 ！sequence.contains {!condition}, 封装一下
    func all(matching predicate: (Iterator.Element) -> Bool) -> Bool {
        // 对于一个条件，如果没有元素不满足它，那么意味着所有元素都满足它
        return !contains {!predicate($0)}
    }
}
