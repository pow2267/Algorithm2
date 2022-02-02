//
//  [프로그래머스] 사용할 수 있는 모든 보조키의 개수 구하기
//  ⭐️⭐️⭐️
//
//  https://programmers.co.kr/learn/courses/30/lessons/42890
//

// 유일성(uniqueness) : 릴레이션에 있는 모든 튜플에 대해 유일하게 식별되어야 한다.
// 최소성(minimality) : 유일성을 가진 키를 구성하는 속성(Attribute) 중 하나라도 제외하는 경우 유일성이 깨지는 것을 의미한다.
// 즉, 릴레이션의 모든 튜플을 유일하게 식별하는 데 꼭 필요한 속성들로만 구성되어야 한다.

import Foundation

func solution(_ relation: [[String]]) -> Int {
    // tuple의 인덱스를 key종류로 만들기 위해 배열을 만들어 인덱스만 추가하기
    var keys: [Int] = []
    
    for i in 0..<relation.first!.count {
        keys.append(i)
    }
    
    // candidateKey가 될 수 있는 모든 index의 조합
    let allKeys: [[Int]] = getAllKeyCases(keys)
    var candidateKeys: [[Int]] = []
    
    // 모든 index조합 중 유일성을 만족하는 index의 조합
    for ak in allKeys {
        if isUnique(ak, relation) {
            candidateKeys.append(ak)
        }
    }
    
    // 유일성을 만족하는 보조키 중 최소성 체크하기
    for (idx, ck) in candidateKeys.enumerated() {
        // 보조키 조합이 가지는 모든 종류의 조합
        let allCase = getAllKeyCases(ck)
        var tempCandidateKeys = candidateKeys
        // 자기 자신을 중복 체크하는 경우가 발생하지 않도록
        tempCandidateKeys.remove(at: idx)
        
        for ac in allCase {
            if tempCandidateKeys.contains(ac) {
                candidateKeys[idx] = []
            }
        }
    }

    return candidateKeys.filter({ !$0.isEmpty }).count
}

// 주어진 keys들로 튜플을 구분할 수 있는 유일성을 만족하는지 체크
private func isUnique(_ keys: [Int], _ relation: [[String]]) -> Bool {
    var sets = Set<String>()

    for tuple in relation {
        var candidateKey = ""

        for key in keys {
            candidateKey += tuple[key]
        }
        
        if sets.contains(candidateKey) {
            return false
        } else {
            sets.insert(candidateKey)
        }
    }

    return true
}

// 주어진 keys가 가질 수 있는 모든 조합 만들기
// <재귀 함수 이용>
private func getAllKeyCases(_ keys: [Int]) -> [[Int]] {
    var keyCases: [[Int]] = []
    
    // keys: 조합을 만들 때 고려할 수 있는, 앞서 사용하고 남은 요소들
    // index: 조합을 만들 때 추가할 요소를 가리키고 있는 인덱스
    // before: 이전까지 만든 조합 결과물
    func makeKeyCases(_ keys: [Int], _ index: Int, _ before: [Int]) {
        var k = keys
        var b = before
        
                // 중복으로 고려하는 걸 막기 위해 remove
        b.append(k.remove(at: index))
        keyCases.append(b)
            
                // 중복으로 고려하는 걸 막기 위해 0이 아니라 index부터 시작
        for i in index..<k.count {
            makeKeyCases(k, i, b)
        }
    }
    
    for i in 0..<keys.count {
        makeKeyCases(keys, i, [])
    }
    
    return keyCases
}
