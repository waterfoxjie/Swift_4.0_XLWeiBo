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
    
    /// 加载微博列表
    ///
    /// - Parameters:
    ///   - isPullup: 是否是上拉刷新
    ///   - completion: completion
    func loadHomeList(isPullup: Bool = false, completion: @escaping (_ isSuccess: Bool) -> Void) {
        let since_id = isPullup ? 0 : homeList.first?.id ?? 0
        let tempMaxId = isPullup ? homeList.last?.id ?? 0 : 0
        let max_id = tempMaxId > 0 ? tempMaxId - 1 : tempMaxId
        // 调用网络方法加载数据
        print("最后一条数据\(homeList.last?.text)")
        XLNetworkManager.shareManager.homeTimelineRequest(since_id: Int64(since_id), max_id: Int64(max_id)) { (list, isSuccess) in
            guard let array = NSArray.yy_modelArray(with: XLHomeInfoModel.self, json: list ?? []) as? [XLHomeInfoModel] else {
                completion(isSuccess)
                return
            }
            // 拼接数据
            if isPullup {
                self.homeList += array
            } else {
                print("下拉刷新到\(array.count)数据")
                self.homeList = array + self.homeList
            }
            // 完成回调
            completion(isSuccess)
        }
    }
}
