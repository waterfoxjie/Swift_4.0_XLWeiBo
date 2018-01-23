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
    // 是否需要请求网络
    private var isHasRequest = true
    
    /// 加载微博列表
    ///
    /// - Parameters:
    ///   - isPullup: 是否是上拉刷新
    ///   - completion: [isSuccess：是否成功，isReloadData：是否刷新数据]
    func loadHomeList(isPullup: Bool = false, completion: @escaping (_ isSuccess: Bool, _ isReloadData: Bool) -> Void) {
        // 判断是否超过最大数量
        if isPullup && !isHasRequest {
            // 超过则直接返回，不走网络请求
            completion(true, false)
            return
        }
        let since_id = isPullup ? 0 : homeList.first?.id ?? 0
        let tempMaxId = isPullup ? homeList.last?.id ?? 0 : 0
        let max_id = tempMaxId > 0 ? tempMaxId - 1 : tempMaxId
        // 调用网络方法加载数据
        print("最后一条数据\(String(describing: homeList.last?.text))")
        XLNetworkManager.shareManager.homeTimelineRequest(since_id: Int64(since_id), max_id: Int64(max_id)) { (list, isSuccess) in
            guard let array = NSArray.yy_modelArray(with: XLHomeInfoModel.self, json: list ?? []) as? [XLHomeInfoModel] else {
                completion(isSuccess, false)
                return
            }
            // 拼接数据
            if isPullup {
                print("上拉刷新到\(array.count)数据")
                self.homeList += array
            } else {
                print("下拉刷新到\(array.count)数据")
                self.homeList = array + self.homeList
            }
            // 判断上拉刷新数量
            if isPullup && array.count == 0 {
                self.isHasRequest = false
                // 回调
                completion(isSuccess, false)
            } else {
                completion(isSuccess, true)
            }
        }
    }
}
