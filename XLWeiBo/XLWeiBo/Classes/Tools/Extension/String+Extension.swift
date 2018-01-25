//
//  String+Extension.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/1/25.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import Foundation

// MARK: - 路径相关
extension String {
    
    /// 拼接 Documnet 路径
    ///
    /// - Returns: 返回拼接好的路径
    func appendDocumnetDir() -> String {
        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documnetPath = documentPaths.first! as NSString
        let filePath = documnetPath.appendingPathComponent(self)
        return filePath
    }
}



