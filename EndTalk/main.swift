//
//  [프로그래머스] 영단어 끝말잇기 결과 도출하기
//
//
//  https://programmers.co.kr/learn/courses/30/lessons/12981
//

import Foundation

func solution(_ n: Int, _ words: [String]) -> [Int] {
    var round = 0
    var index = 1
    var wordsList: [String] = [words.first!]
    
    while round * n + index < words.count {
        let word = words[round * n + index]
        
        if let lastWord = wordsList.last,
            lastWord.map({String($0)}).last != word.map({String($0)}).first {
            return [index+1, round+1]
        }
        
        if wordsList.contains(word) {
            return [index+1, round+1]
        }
        
        wordsList.append(word)
        index += 1
        
        if index == n {
            round += 1
            index = 0
        }
    }
    
    return [0, 0]
}
