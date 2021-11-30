import UIKit
import Foundation

class ListViewController : UITableViewController {
    
    // 테이블 뷰를 구성할 리스트 데이터
    // lazy : 클래스의 인스턴스 생성 시 초기화 아닌, 프로퍼티를 호출 해야만 초기화.
    // 클로저 구문을 사용한 프로퍼티 초기화 : 연산으로 얻어진 값을 이용하여 초기화
    lazy var list: [MovieVO] = {
        
        //MovieVO타입의 배열로 초기화
        // 초기값을 모아 초기값 배열 객체 만듬
        var datalist = [MovieVO]()

        return datalist
        // 연산의 초기값을 받고싶으니 클로저구문을 사용하여받음 = return으로 초기값받음
        // 변수의 초기값은 datalist
        
    }()
    

    // 뷰컨트롤러가 초기화 되면서 뷰가 '메모리에 로딩'(인스턴스) 될 때 호출되는 메소드. 처음 한번만 실행되는 로직을 구현
    override func viewDidLoad(){
        // 1 호핀 api 호출을 위한 URI 생성
        let url = "http://swiftapi.rubypaper.co.kr:2029/hoppin/movies?version=1&page=1&count=10&genreId=&order=releasedateasc"
        
        // 주소를 파운데이션 프레임워크에 정의된 URL 객체(구조체)를 써서 문자열 주소 -> URL 타입으로 만듬
        let apiURI : URL! = URL(string: url)
        
        // 1. Data(contentsOf:) : REST API를 호출 (네트워크 주소를 URL 타입으로 넣어줘야햠)
        // try! : 오류를 던지도록 만든 메소드이지만 , 필요에 의해 오류를 던지지 않게 하고 싶을 때
        let apidata = try! Data(contentsOf: apiURI)
        
        // ③ 데이터 전송 결과를 로그로 출력 (반드시 필요한 코드는 아님)
        let log = NSString(data: apidata, encoding: String.Encoding.utf8.rawValue) ?? ""
        NSLog("API Result=\( log )")
        
        do {
            // 테이블을 구성하는 데이터로 사용하기 위해NSDictionary 객체로 캐스팅
            let apiDictionay = try JSONSerialization.jsonObject(with: apidata, options: []) as! NSDictionary
            
            let hoppin = apiDictionay["hoppin"] as! NSDictionary
            let movies = hoppin["movies"] as! NSDictionary
            let movie = movies["movie"] as! NSArray
            
            
            for row in movie {
                
                let r = row as! NSDictionary
                
                let mvo = MovieVO()
                
                mvo.title = r["title"] as? String
                mvo.description = r["genreNames"] as? String
                mvo.thumbnail = r["thumbnailImage"] as? String
                mvo.detail = r["linkUrl"] as? String
                mvo.rating = ((r["ratingAverage"] as! NSString).doubleValue)
                
                self.list.append(mvo)
            }
            
        }catch {}
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //행에 맞는 데이터소스 읽어옴
        let row = self.list[indexPath.row]
        
        // 재사용 큐를 가져옴
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! MovieCell
        

        cell.title?.text = row.title
        cell.desc?.text = row.description
        cell.opendate?.text = row.opendate
        cell.rating?.text = "\(row.rating!)"
        
        let url: URL! = URL(string: row.thumbnail!)
        
        let imageData = try! Data(contentsOf: url)
        
        cell.thumbnail.image = UIImage(data:imageData)
        
        //이미지뷰 처리
        cell.thumbnail.image = UIImage(named: try! Data(contentsOf: URL(string:row.thumbnail!)!))
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 행은\(indexPath.row)번째 행입니다.")
    }
    
}
