//
//  FavoriteView.swift
//  MyNewExampleTest
//
//  Created by bro on 2022/07/26.
//

import UIKit

import SnapKit

final class FavoriteView: BaseUIView {
    
    var favoriteTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func setupView() {
        super.setupView()
        addSubview(favoriteTableView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        favoriteTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
