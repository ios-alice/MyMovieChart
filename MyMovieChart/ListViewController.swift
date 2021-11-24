import UIKit

class ListViewController : UITableViewController {
    
    // 4. 튜플로 데이터 세트 : 데이터 단순나열, 묶음
    var dataset = [
        ("다크나이트", "영웅물에 철학에 음악까지 더해져 예술이되다.","2008-09-04", 8.95),
        ("호우시절", "때를 알고 내리는 좋은 비", "2008-10-22", 7.31),
        ("말할 수 없는 비밀", "여기서 너 까지 다섯걸음", "2003-14-34", 3.33)
    ]
    
    // 테이블 뷰를 구성할 리스트 데이터
    // lazy : 클래스의 인스턴스 생성 시 초기화 아닌, 프로퍼티를 호출 해야만 초기화.
    // 클로저 구문을 사용한 프로퍼티 초기화 : 연산으로 얻어진 값을 이용하여 초기화
    lazy var list: [MovieVO] = {
        var datalist = [MovieVO]()
        //for - in 구문 : in을 반복하여 for에 대입한다.
        for (title, desc, opendate, rating) in self.dataset {
            let mvo = MovieVO()
            mvo.title = title
            mvo.description = desc
            mvo.opendate = opendate
            mvo.rating = rating
            
            datalist.append(mvo)
        }
        return datalist
        // 변수의 초기값은 datalist
    }()
    

    // 뷰컨트롤러가 초기화 되면서 뷰가 메모리에 로딩 될 때 호출되는 메소드. 처음 한번만 실행되는 로직을 구현
    override func viewDidLoad(){

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //행에 맞는 데이터소스 읽어옴
        let row = self.list[indexPath.row]
        
        // 재사용 큐를 가져옴
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell")!
        
        let title = cell.viewWithTag(101) as? UILabel
        let desc = cell.viewWithTag(102) as? UILabel
        let opendate = cell.viewWithTag(103) as? UILabel
        let rating = cell.viewWithTag(104) as? UILabel
        
        title?.text = row.title
        desc?.text = row.description
        opendate?.text = row.opendate
        rating?.text = "\(row.rating!)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 행은\(indexPath.row)번째 행입니다.")
    }
    
}
