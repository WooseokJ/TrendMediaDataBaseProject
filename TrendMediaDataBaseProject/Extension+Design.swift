
import Foundation
import SwiftUI

extension UINavigationItem {
    func navBarDesign() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithDefaultBackground()
        self.scrollEdgeAppearance = navigationBarAppearance
        self.standardAppearance = navigationBarAppearance
        self.standardAppearance = navigationBarAppearance
        self.scrollEdgeAppearance = navigationBarAppearance
        self.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchClicked))
//        self.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(listClicked))
        
    }

//    @objc func listClicked() {
//        let next = UIStoryboard(name: "Main", bundle: nil)
//        let vc = next.instantiateViewController(withIdentifier: MapViewController.reuseIdentifier) as! MapViewController
//        MainViewController.navigationController?.pushViewController(vc, animated: true)
//        print(33)
//    }
    
    @objc func searchClicked() {
        return
    }
}
//extension MainViewController {
//    @objc func listClicked() {
//        let next = UIStoryboard(name: "Main", bundle: nil)
//        let vc = next.instantiateViewController(withIdentifier: MapViewController.reuseIdentifier) as! MapViewController
//        self.navigationController?.pushViewController(vc, animated: true)
//        print(33)
//    }
//}


