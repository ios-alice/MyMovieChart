import UIKit
import WebKit





class DetailViewController : UIViewController {
    @IBOutlet var wv : WKWebView!
    var mvo: MovieVO!
    
    override func viewDidLoad() {
        NSLog("linkurl = \(self.mvo.detail!), title = \(self.mvo.title!)")
        
        let navibar = self.navigationItem
        navibar.title = self.mvo.title
        
        //URL인스턴스를 생성한다.
        let url = URL(string: (self.mvo.detail)!)
        let req = URLRequest(url: url!)
        
        // loadRequest 메소드를 호출하면서 req를 인자값으로 전달한다.
        self.wv.load(req)
    }
}
