import UIKit


class TheaterListController : UITableViewController {
    
    // API를 통해서 온 데이터를 저장할 배열 변수
    // 테이블 뷰에 넣을 배열형태의 데이터 집합
    var list = [NSDictionary]()
    
    // 읽어올 데이터의 시작 위치
    var startPoint = 0
    
    // 1. 뷰컨트롤러가 메모리에 로드 되고 call 되는 함수를 오버로딩
    override func viewDidLoad() {
        
        //self:나 또는 부모의 인스턴스의
        // 2. callTeaterAPI()호출
        self.callTheaterAPI()
    }
    
    // 3.API로부터 극장 정보를 읽어오는 메소드
    func callTheaterAPI() {

        let requestURI = "http://swiftapi.rubypaper.co.kr:2029/theater/list" //API 요청주소
        let sList = 100 // 불러올 데이터 개수
        let type = "json" // 데이터 형식
        
        // 4.인자값을 모아 URL 객체로 정의한다.. = String => URL 타입 (API호출은 URL 타입으로 함)
        let urlObj = URL(string: "\(requestURI)?s_page=\(self.startPoint)&s_list=\(sList)&type=\(type)")
        
        do {
            // Point1. Rest API 호출 : NSString(contentsOf:encoding:) : 객체를 이용하여 API를호출하고 그 결과값을 인코딩을 지정한 문자열(EUC-KR=080000522)로 받아온다.
            // 영화관목록은 한글까지 문제없이 처리하는 UTF-8과는 달리, EUC-KR로 되어있어서 데이터를 읽어올 때 EUC-KR로 지정해서? 인코딩하면서 호출
            let stringdata = try NSString(contentsOf: urlObj!, encoding: 0x80_000_422)
            
            // Point2. Data 객체 생성 ; 문자열로 받은 데이터를 -> UTF-8로 인코딩처리한 Data타입으로 변환한다. (EUC-KR -> UTF-8)
            // Data 타입은 utf-8 밖에 못받나봄?
            let encdata = stringdata.data(using:String.Encoding.utf8.rawValue)
            
            do {
                // Point3. 파싱 : Data 객체를 파싱하여 NSArray 객체로 변환한다. Json 배열타입임으로 타입캐스팅한다.
                let apiArray = try JSONSerialization.jsonObject(with: encdata!, options: []) as? NSArray
                
                // 읽어온 데이터르르 순회하며 self.list  배열에 추가한다.
                for obj in apiArray! {
                    self.list.append(obj as! NSDictionary)
                }
        } catch {
            //경고창 형식으로 오류 메시지를 표시해준다.
            let alert = UIAlertController(title: "실패", message: "데이터 분석에 실패하였습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"확인", style: .cancel))
            self.present(alert, animated: false)
        }
        // 9.읽어와야 할 다음 페이지의 데이터 시작 위치를 구해 저장해둔다.
            self.startPoint += sList
    } catch {
    //경고창 형식으로 오류를 표시해준다.
        let alert = UIAlertController(title: "실패", message: "데이터를 불러오는데 실패했습니다", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .cancel))
        self.present(alert, animated: false)
    }
    
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //self.list 배열에서 행에 맞는 데이터 꺼냄
        let obj = self.list[indexPath.row]
        
        //재사용 큐로부터 tCell 식별자에 맞는 셀 객체를 전달받음
        let cell = tableView.dequeueReusableCell(withIdentifier: "tCell") as! TheaterCell
        
        cell.name?.text = obj["상영관명"] as? String
        cell.tel?.text = obj["연락처"] as? String
        cell.addr?.text = obj["소재지도로명주소"] as? String
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "segue_map") {
            //세그위에 식별자가 segue_map 이라면
            
            //선택된 셀의 행 정보
            let path = self.tableView.indexPath(for: sender as! UITableViewCell)
            
            //선택된 셀에 사용된 데이터
            let data = self.list[path!.row]
            
            //세그웨이가 이동할 목적지 뷰 컨트롤러 객체를 구하고
            //선언된 param 변수에 데이터터를 연결해준다.
            (segue.destination as? TheaterViewController)?.param = data
        }
    }
}
