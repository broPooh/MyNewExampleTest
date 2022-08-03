//
//  DetailView.swift
//  MyNewExampleTest
//
//  Created by bro on 2022/07/26.
//

import UIKit
import WebKit

import SnapKit

final class DetailView: BaseUIView {
    
    var movieInfoView = MovieInfoView()
    
    var webView: WKWebView = {
       let webView = WKWebView()
        webView.backgroundColor = .yellow
        return webView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func setupView() {
        super.setupView()
        addSubview(movieInfoView)
        addSubview(webView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        movieInfoView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(120)
        }
        
        webView.snp.makeConstraints { make in
            make.top.equalTo(movieInfoView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
}
