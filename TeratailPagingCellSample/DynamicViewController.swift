//
//  DynamicViewController.swift
//  TeratailPagingCellSample
//
//  Created by 山田隼也 on 2020/05/19.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import UIKit

final class DynamicViewController: UIViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    
    struct Model {
        var page: Int = 0
        
        let images: [UIImage]
        let descriptionText: String?
    }
    
    private var dataSource: [Model] = [
        Model(images: [UIImage(systemName: "0.square")!, UIImage(systemName: "01.square")!],
              descriptionText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque eu tristique ligula. Quisque est ligula, convallis eu arcu at, eleifend aliquam orci. Donec auctor risus eu mi cursus, eget fringilla dui sodales. "),
        Model(images: [UIImage(systemName: "0.square")!, UIImage(systemName: "01.square")!, UIImage(systemName: "02.square")!, UIImage(systemName: "03.square")!],
              descriptionText: "Duis blandit rhoncus massa, nec dignissim turpis dignissim eget."),
        Model(images: [UIImage(systemName: "0.square")!, UIImage(systemName: "01.square")!, UIImage(systemName: "02.square")!],
              descriptionText: "Nullam id porttitor mi. Vivamus fringilla, quam maximus sagittis sollicitudin, dui massa pretium leo, id lobortis massa dolor vitae justo. Pellentesque eu rhoncus sem."),
        Model(images: [UIImage(systemName: "0.square")!],
              descriptionText: "Quisque pharetra cursus velit, quis iaculis ex facilisis nec.")
    ]
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
}

extension DynamicViewController {
    
    private func configureTableView() {
        tableView.dataSource = self
//        tableView.delegate = self
        tableView.separatorInset = .zero
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 286
        tableView.register(DynamicTableCell.nib, forCellReuseIdentifier: DynamicTableCell.reuseIdentifier)
    }
}

extension DynamicViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell    = tableView.dequeueReusableCell(withIdentifier: DynamicTableCell.reuseIdentifier, for: indexPath) as! DynamicTableCell
        let model   = dataSource[indexPath.row]
        cell.configure(with: model.page, images: model.images, descriptionText: model.descriptionText)
        cell.onScrollViewDidEndDecelerating = { [weak self] page in
            guard let self = self else { return }
            var copiedDataSource = self.dataSource
            copiedDataSource[indexPath.row].page = page
            self.dataSource = copiedDataSource
            self.tableView.reloadData()
        }
        return cell
    }
}
