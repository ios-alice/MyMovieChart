import UIKit
import MapKit

class TheaterViewController : UIViewController {
    //전달되는 데이터를 받을 변수
    var param: NSDictionary!
    
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        self.navigationItem.title = self.param["상영관명"] as? String
        
        // 위도와 경도를 추출, Double 값으로 캐스팅
        // 위도와 경도는 String으로 받아지는데 NSString의 .doubleVlaue 속성으로, 필요한 Double 타입으로 변환한다.
        let lat = (param?["위도"] as! NSString).doubleValue
        let lng = (param?["경도"] as! NSString).doubleValue
        
        // 위도와 경도를 인수로하는 2D위치정보 객체 정의
        // 중심좌표를 정한다.
        let location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        
        // 지도에 표현 될 거리 (단위는 m)
        let regionRadius : CLLocationDistance = 100
        
        // 지도 데이터 생성 : 거리를 반영한 지역정보를 조합한
        let coordinateRegin = MKCoordinateRegion(center: location, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        
        // 지도 객체에 (map) 데이터 전달하여 화면 표시
        self.map.setRegion(coordinateRegin, animated: true)
    }
    
}
