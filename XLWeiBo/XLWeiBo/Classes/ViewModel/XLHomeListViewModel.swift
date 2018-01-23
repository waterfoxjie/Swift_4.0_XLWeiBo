//
//  XLHomeListViewModel.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/1/19.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import Foundation

class XLHomeListViewModel {
    // 微博模型数组懒加载
    lazy var homeList = [XLHomeInfoModel]()
    
    // 加载微博列表
    func loadHomeList(completion: @escaping (_ isSuccess: Bool) -> Void) {
        let since_id = homeList.first?.id ?? 0
        // 调用网络方法加载数据
        XLNetworkManager.shareManager.homeTimelineRequest(since_id: Int64(since_id), max_id: 0) { (list, isSuccess) in
            guard let array = NSArray.yy_modelArray(with: XLHomeInfoModel.self, json: list ?? []) as? [XLHomeInfoModel] else {
                completion(isSuccess)
                return
            }
            print("刷新到\(array.count)数据")
            // 拼接数据
            self.homeList = array + self.homeList
            // 完成回调
            completion(isSuccess)
        }
    }
}
