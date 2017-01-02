//
//  TableViewController.swift
//  SAiOS-FlickrViewerLiveCoding
//
//  Created by Key Hoffman on 1/2/17.
//  Copyright © 2017 Key Hoffman. All rights reserved.
//

import UIKit

// MARK: - TableViewController

class TableViewContoller<Cell: UITableViewCell>: UITableViewController where Cell: Configurable { // TODO: MAKE THIS A PROTOCOL!!!!!
    
    typealias DataType = Cell.DataType
    
    // MARK: - Property Declarations
    
    private let cellIdentifier = String(describing: Cell.self)
    
    lazy var emptyMessageLabel: UILabel = { [weak self] in
        let l           = UILabel.init <| CGRect(x: 0, y: 0, width: self?.view.bounds.width ?? 0, height: self?.view.bounds.height ?? 0)
        l.tag           = 0
        l.text          = "No data available"
        l.textColor     = .red
        l.textAlignment = .center
        l.sizeToFit()
        return l
        }()
    
    lazy var spinner: UIActivityIndicatorView = { [weak self] in
        let s = UIActivityIndicatorView(activityIndicatorStyle: .white)
        s.hidesWhenStopped = true
        s.center = self?.tableView.center ?? .zero
        return s
        }()
    
    
    var data: [DataType] = [] {
        didSet {
            defer {
                tableView.reloadData()
                refreshControl?.endRefreshing()
                spinner.stopAnimating()
            }
            guard data.count > 0 else {
                setEmptyBackgroundLabel()
                return
            }
            guard let _ = tableView.backgroundView else { return }
            removeEmptyBackgroundLabel()
        }
    }
    
    // MARK: - Initialization
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Empty Dataset Handling
    
    func setEmptyBackgroundLabel() {
        tableView.backgroundView = emptyMessageLabel
        tableView.separatorStyle = .none
    }
    
    func removeEmptyBackgroundLabel() {
        tableView.backgroundView = nil
        tableView.separatorStyle = .singleLine
    }
    
    // MARK: - ViewController Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(Cell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.addSubview(spinner)
        tableView.separatorStyle = .none
        spinner.startAnimating()
    }
    
    // MARK: - UITableViewDatasource Conformance Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? Cell else {
            fatalError(FatalError.couldNotDequeueCell(identifier: cellIdentifier).debugDescription)
            
        }
        cell.configure <| data[indexPath.row]
        return cell
    }
}
