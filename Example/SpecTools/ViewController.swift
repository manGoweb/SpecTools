//
//  ViewController.swift
//  SpecTools
//
//  Created by manGoweb on 08/25/2017.
//  Copyright (c) 2017 manGoweb. All rights reserved.
//

import UIKit
import SnapKit


class ViewController: UIViewController {
    
    let scrollView = UIScrollView()
    
    let label1 = UILabel()
    let label2 = UILabel()
    let label3 = UILabel()
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // Label 1
        label1.text = "My first label"
        label1.textAlignment = .center
        view.addSubview(label1)
        label1.snp.makeConstraints { (make) in
            make.top.equalTo(44)
            make.left.right.equalToSuperview()
        }
        
        // Screate scroll view
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(label1.snp.bottom).offset(12)
            make.left.right.bottom.equalToSuperview()
        }
        
        // Label 2
        label2.text = "My second label sitting in a scrollview"
        label2.textAlignment = .center
        scrollView.addSubview(label2)
        label2.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalTo(label1)
        }
    }
    
}

