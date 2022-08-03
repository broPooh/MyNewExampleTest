//
//  ViewController.swift
//  MyNewExampleTest
//
//  Created by bro on 2022/08/03.
//

import UIKit

enum ViewController {
    case main(SearchView, SearchViewModel)
    case favorite(FavoriteView, FavoriteViewModel)
    case detail(DetailView, DetailViewModel)
}
