import Foundation




// 1. 데이터 소스 만들기 : 영화정보를 담을 객체
// 데이터 저장을 전담하는 클래스를 별도로 분리하는 설계 방식 : Value Object  패턴(VO)
class MovieVO {
    var thumbnail: String? // 영화 썸네일 이미지 주소
    var title: String? // 영화 제목
    var description: String? // 영화 설명
    var detail: String? // 상세정보
    var opendate: String? // 개봉일
    var rating: Double? // 평점
}
