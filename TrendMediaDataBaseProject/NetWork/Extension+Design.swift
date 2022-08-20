
import Foundation
import SwiftUI

extension UINavigationItem {
    // 네비바 디자인
    func navBarDesign() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithDefaultBackground()
        self.scrollEdgeAppearance = navigationBarAppearance
        self.standardAppearance = navigationBarAppearance
        self.standardAppearance = navigationBarAppearance
        self.scrollEdgeAppearance = navigationBarAppearance
        self.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchClicked))
    }
    // 검색 버튼 클릭시
    @objc func searchClicked() {
        return
    }
}
extension MainViewController {
    // 지도 맵 보기
    @objc func listClicked() {
        let next = UIStoryboard(name: "Main", bundle: nil)
        let vc = next.instantiateViewController(withIdentifier: MapViewController.reuseIdentifier) as! MapViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


