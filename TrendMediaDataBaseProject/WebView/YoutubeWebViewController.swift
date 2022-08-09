import UIKit
import WebKit

import Alamofire
import SwiftyJSON
class YoutubeWebViewController: UIViewController {
    var link: String?
    @IBOutlet weak var webView: WKWebView!
    var destinationURL:String = endPoint.youtubeURL
   
    override func viewDidLoad() {
        super.viewDidLoad()
        destinationURL+=link!
        DispatchQueue.main.async {
            self.openWebPage(url:self.destinationURL)
        }
    }

    //MARK: 웹사이트열기
    func openWebPage(url:String){
        guard let url = URL(string: url) else{ return}
        let request = URLRequest(url:url)
        webView.load(request)
    }
    
   
}
