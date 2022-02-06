//
//  [프로그래머스] H-Index 구하기
//
//
//  https://programmers.co.kr/learn/courses/30/lessons/42747
//

import Foundation

func solution(_ citations: [Int]) -> Int {
    var maxH = 0
    
    var ordered = citations
    // 가장 큰 수를 구하기 위함이니까 처음 조건을 만족한 값이 가장 큰 값이 되도록 내림차순으로 정렬
    ordered.sort(by: >)
    
    // 주의! 인용 횟수인 i가 꼭 citations 배열 안에 있는 값일 필요는 없다!!
    for i in (0..<ordered[0]).reversed() {
        for (index, citation) in ordered.enumerated() {
            // 논문 인용 횟수가 i이상이고, 그 개수가 i이상이기 위해
            // 배열의 index는 0부터 시작하니까 개수를 맞추려면 (index+1)
            if citation >= i && index + 1 >= i {
                return i
            }
        }
    }
    
    return maxH
}
