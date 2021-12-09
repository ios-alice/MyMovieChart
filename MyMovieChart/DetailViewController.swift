import UIKit
import WebKit





class DetailViewController : UIViewController {
    
    @IBOutlet var wv : WKWebView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var mvo: MovieVO!
    
    override func viewDidLoad() {
        
        // 프로토콜은 그에 맞는 델리게이트 객체 지정용 멤버변수를 가진다.
        // 이 클래스에 델리게이트 메소드를 구현할테니 웹뷰에 변화가 있을 떄 맞는 메소드를 호출해주세요.
        self.wv.navigationDelegate = self
    
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

// MARK:- WKNavigationDelegate 의 프로토콜 구현
extension DetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        self.spinner.startAnimating() //인디케이터 뷰의애니메이션 실행
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.spinner.stopAnimating() //인디케이터 뷰의애니메이션 실행
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.spinner.stopAnimating() //인디케이터 뷰의애니메이션 실행
    
        let alert = UIAlertController(title: "오류",
                                      message: "상세페이지를 읽어오지 못했습니다.",
                                      preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title:"확인", style: .cancel) { (_) in
            //이전화면으로 돌려보낸다.
            _ = self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(cancelAction)
        self.present(alert, animated: false, completion: nil)
    }
}
