//
//  Extension.swift
//  AdvanceSwift
//
//  Created by EastElsoft on 2018/2/6.
//  Copyright © 2018年 AnatoleZho. All rights reserved.
//

import Foundation



// 获取序列中所有的唯一元素，并保持顺序不变
/*
   集合： 元素唯一性，但是顺序不固定
 
 */
extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter {
            if seen.contains($0) {
                return false
            } else {
                seen.insert($0)
                return true
            }
        }
    }
}


