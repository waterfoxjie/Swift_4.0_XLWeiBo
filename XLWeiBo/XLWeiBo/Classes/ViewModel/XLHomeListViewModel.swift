//
//  XLHomeListViewModel.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/1/19.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import Foundation
import ObjectMapper

/// 微博列表视图模型
class XLHomeListViewModel {
    // 微博视图模型数组懒加载
    lazy var homeList = [XLHomeViewModel]()
    // 是否需要请求网络
    private var isHasRequest = true
    
    /// 加载微博列表
    ///
    /// - Parameters:
    ///   - isPullup: 是否是上拉刷新
    ///   - completion: [isSuccess：是否成功，isReloadData：是否刷新数据]
    func loadHomeList(isPullup: Bool = false, completion: @escaping (_ isSuccess: Bool, _ isReloadData: Bool) -> Void) {
        if isPullup && !isHasRequest {
            // 超过则直接返回，不走网络请求
            completion(true, false)
            return
        }
        let since_id = isPullup ? 0 : homeList.first?.homeModel.wbID ?? 0
        let tempMaxId = isPullup ? homeList.last?.homeModel.wbID ?? 0 : 0
        let max_id = tempMaxId > 0 ? tempMaxId - 1 : tempMaxId
        // 调用网络方法加载数据
        print("最后一条数据\(String(describing: homeList.last?.homeModel.wbText))")
        XLNetworkManager.shareManager.homeTimelineRequest(since_id: Int64(since_id), max_id: Int64(max_id)) { (list, isSuccess) in
            // 判断网络请求是否成功
            if !isSuccess {
                completion(false, false)
                return
            }
            // 定义可变的视图模型数组
            var viewModelArray = [XLHomeViewModel]()
            // 遍历获取到的数据，进行字典转模型操作
            for dict in list ?? [] {
                // 若模型转换失败，则继续下一次操作
                guard let model = Mapper<XLHomeInfoModel>().map(JSON: dict) else {
                    continue
                }
                viewModelArray.append(XLHomeViewModel(model: model))
            }
            // 拼接数据
            if isPullup {
                print("上拉刷新到\(viewModelArray.count)数据")
                self.homeList += viewModelArray
            } else {
                print("下拉刷新到\(viewModelArray.count)数据")
                self.homeList = viewModelArray + self.homeList
            }
            // 判断上拉刷新数量
            if isPullup && viewModelArray.count == 0 {
                self.isHasRequest = false
                // 回调
                completion(isSuccess, false)
            } else {
                // 做缓存单张图像处理
                self.cacheSingleImage(list: viewModelArray)
                completion(isSuccess, true)
            }
        }
    }
    
    /// 缓存本次下载微博数据数组中的单张图像
    ///
    /// - Parameter list: 数据模型
    private func cacheSingleImage(list: [XLHomeViewModel]) {
        // 遍历数组
        for vm in list {
            // 若没有图像或者图像多于 1 张则进行下一次循环
            if vm.picUrlArray == nil || vm.picUrlArray?.count != 1 {
                continue
            }
            // 获取到图片 Url
            guard let picString = vm.picUrlArray?.first?.thumbnailPic,
                let picUrl = URL(string: picString) else {
                    continue
            }
            print("picUrl = \(picUrl)")
        }
    }
}
