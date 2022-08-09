//
//  ImageDownloadViewController.swift
//  CJLCustomInstruments
//
//  Created  by CJL on 2022/8/3.
//  Copyright © 2022 CoderCJL. All rights reserved.
//

import UIKit

class ImageDownloadViewController: UITableViewController {
    /// 所有的图片数据
    var datas:[CJLImageDownload] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(CJLImageDownloadCell.self, forCellReuseIdentifier: "Cell")
        
        // mock 数据
        var mock:[CJLMockData] = []
        for i in 1...10 {
            let mockData = CJLMockData()
            mockData.name = "name\(i)"
            mock.append(mockData)
        }
        
        for _ in 0...300 {
            let index_ = (Int)(arc4random()%(UInt32)(mock.count))
            let mockData = mock[index_]
            
            let imageData = CJLImageDownload()
            imageData.mockData = mockData;
            
            datas.append(imageData)
        }
    }
}

/// UITableViewDataSource
extension ImageDownloadViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CJLImageDownloadCell
        
        let imageData = datas[indexPath.row]
        cell.imageData = imageData
        
        return cell
    }
}


