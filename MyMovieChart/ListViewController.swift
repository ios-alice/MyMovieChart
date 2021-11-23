import UIKit

class ListViewController : UITableViewController {
    
    // 4. 튜플로 데이터 세트 : 데이터 단순나열, 묶음
    var dataset = [
        ("다크나이트", "영웅물에 철학에 음악까지 더해져 예술이되다.","2008-09-04", 8.95),
        ("호우시절", "때를 알고 내리는 좋은 비", "2008-10-22", 7.31),
        ("말할 수 없는 비밀", "여기서 너 까지 다섯걸음", "2003-14-34", 3.33)
    ]
    
    // 테이블 뷰를 구성할 리스트 데이터
    lazy var list: [MovieVO] = {
        var datalist = [MovieVO]()
        for (title, desc, opendate, rating) in self.dataset {
            let mvo = MovieVO()
            mvo.title = title
            mvo.description = desc
            mvo.opendate = opendate
            mvo.rating = rating
            
            datalist.append(mvo)
        }
        return datalist
    }()
    

    // 뷰컨트롤러가 초기화 되면서 뷰가 메모리에 로딩 될 때 호출되는 메소드. 처음 한번만 실행되는 로직을 구현
    override func viewDidLoad(){

    }
    
    
    
}
