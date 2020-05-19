//
//  FixedViewController.swift
//  TeratailPagingCellSample
//
//  Created by 山田隼也 on 2020/05/18.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import UIKit

class FixedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    struct Model {
        var page: Int = 0
        
        let descriptionText: String?
    }
    
    private var dataSource: [Model] = [
        Model(descriptionText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque eu tristique ligula. Quisque est ligula, convallis eu arcu at, eleifend aliquam orci. Donec auctor risus eu mi cursus, eget fringilla dui sodales. "),
        Model(descriptionText: "Duis blandit rhoncus massa, nec dignissim turpis dignissim eget."),
        Model(descriptionText: "Nullam id porttitor mi. Vivamus fringilla, quam maximus sagittis sollicitudin, dui massa pretium leo, id lobortis massa dolor vitae justo. Pellentesque eu rhoncus sem."),
        Model(descriptionText: "Quisque pharetra cursus velit, quis iaculis ex facilisis nec."),
        Model(descriptionText: "Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Nam enim enim, mattis posuere fermentum sit amet, bibendum et sapien."),
        Model(descriptionText: "Curabitur pharetra risus nec libero malesuada vestibulum. Suspendisse potenti. Mauris facilisis sapien vel dolor aliquam, vitae tempus enim bibendum. "),
        Model(descriptionText: "Nam commodo nisi ac nunc sodales facilisis. Nunc accumsan posuere auctor. Nulla elementum eget nulla at interdum. Maecenas volutpat ut lorem eu vehicula."),
        Model(descriptionText: "Duis blandit rhoncus massa, nec dignissim turpis dignissim eget."),
        Model(descriptionText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque eu tristique ligula. Quisque est ligula, convallis eu arcu at, eleifend aliquam orci. Donec auctor risus eu mi cursus, eget fringilla dui sodales. "),
        Model(descriptionText: "Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Nam enim enim, mattis posuere fermentum sit amet, bibendum et sapien.")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
}

// MARK: - Configure

extension FixedViewController {
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorInset = .zero
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 286
        tableView.register(FixedTableCell.nib, forCellReuseIdentifier: FixedTableCell.reuseIdentifier)
    }
}

extension FixedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell    = tableView.dequeueReusableCell(withIdentifier: FixedTableCell.reuseIdentifier, for: indexPath) as! FixedTableCell
        let model   = dataSource[indexPath.row]
        cell.configure(with: model.page, descriptionText: model.descriptionText)
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

extension FixedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
