//
//  PageViewController.swift
//  TrendMediaDataBaseProject
//
//  Created by useok on 2022/08/17.
//

import UIKit

class PageViewController: UIPageViewController {

    var pageViewControllerList : [UIViewController] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        createPageViewContoller()
    }
    func createPageViewContoller() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = sb.instantiateViewController(withIdentifier: FirstViewController.reuseIdentifier) as! FirstViewController
        let vc2 = sb.instantiateViewController(withIdentifier: SecondViewController.reuseIdentifier) as! SecondViewController
        let vc3 = sb.instantiateViewController(withIdentifier: ThirdViewController.reuseIdentifier) as! ThirdViewController
        pageViewControllerList = [vc1, vc2, vc3]
    }
//    func configurePageViewController() {
//        delegate = self
//        dataSource = self
//        // display
//        guard let first = pageViewControllerList.first else {return}
//        setViewControllers([first], direction: .forward, animated: true)
//    }

}


