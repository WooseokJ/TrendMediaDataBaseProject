import UIKit
import WebKit

import Alamofire
import SwiftyJSON
class YoutubeWebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    var youtubeTVID : String?
    var destinationURL:String = endPoint.youtubeURL
   
    override func viewDidLoad() {
        super.viewDidLoad()
        destinationURL += youtubeTVID!        
        DispatchQueue.main.async {
            self.openWebPage(url:self.destinationURL)
        }
    }
    
    func openWebPage(url:String){
        guard let url = URL(string: url) else{ return}
        let request = URLRequest(url:url)
        webView.load(request)
    }
   
}
