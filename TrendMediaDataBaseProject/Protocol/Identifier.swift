import Foundation
import UIKit

protocol ReuseIdentifier {
    static var reuseIdentifier: String { get }
}

extension UIViewController: ReuseIdentifier {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReuseIdentifier {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReuseIdentifier {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
