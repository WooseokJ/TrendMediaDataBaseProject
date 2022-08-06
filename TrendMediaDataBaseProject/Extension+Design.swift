
import Foundation
import SwiftUI

extension UINavigationItem {
    func navBarDesign() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithDefaultBackground()
        self.scrollEdgeAppearance = navigationBarAppearance
        self.standardAppearance = navigationBarAppearance
        self.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(listClicked))
        self.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchClicked))
        self.standardAppearance = navigationBarAppearance
        self.scrollEdgeAppearance = navigationBarAppearance
        
    }
    @objc func listClicked() {
        return
    }
    @objc func searchClicked() {
        return
    }
}
