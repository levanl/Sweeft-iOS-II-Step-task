import UIKit




// MARK: Task 1

func lengthOfLongestSubstring(_ s: String) -> Int {
    var mappedChar: [Character: Int] = [:]
    var longest: Int = 0
    var start = 0
    
    for (i, char) in s.enumerated() {
        if let lastSeen = mappedChar[char], lastSeen >= start {
            start = max(start, lastSeen + 1)
        }
        
        longest = max(longest, i - start + 1)
        
        mappedChar[char] = i
    }
    
    return longest
}

print(lengthOfLongestSubstring("abcabcbb"))
print(lengthOfLongestSubstring("bbbbb"))


// MARK: Task 2

func minWindow(_ s: String, _ t: String) -> String {
    
    var charCount = [Character: Int]()
    for char in t {
        charCount[char, default: 0] += 1
    }
    
    var left = 0
    var minLeft = 0
    var minLength = Int.max
    var count = 0
    
    let sArray = Array(s)
    
    for right in 0..<sArray.count {
        let char = sArray[right]
        if let value = charCount[char] {
            charCount[char] = value - 1
            if value > 0 {
                count += 1
            }
        }
        while count == t.count {
            if right - left + 1 < minLength {
                minLength = right - left + 1
                minLeft = left
            }
            let leftChar = sArray[left]
            if let value = charCount[leftChar] {
                charCount[leftChar] = value + 1
                if value == 0 {
                    count -= 1
                }
            }
            left += 1
        }
    }
    
    return minLength == Int.max ? "" : String(sArray[minLeft..<minLeft+minLength])
    
}

let s = "a"
let t = "aa"
print(minWindow(s, t))


// MARK: Task 3

func wordBreak(_ s: String, _ words: [String]) -> Bool {
    let wordSet = Set(words)
    var dp = [Bool](repeating: false, count: s.count + 1)
    dp[0] = true
    
    let sArray = Array(s)
    
    for i in 1...sArray.count {
        for j in 0..<i {
            if dp[j] && wordSet.contains(String(sArray[j..<i])) {
                dp[i] = true
                break
            }
        }
    }
    
    return dp[s.count]
}

let v = "applepenapple"
let words = ["apple", "pen"]
print(wordBreak(v, words))


// MARK: Task 4

func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
    
    var frequencyMap = [Int: Int]()
    
    for num in nums {
        frequencyMap[num, default: 0] += 1
    }
    
    let sortedByFrequency = frequencyMap.sorted { $0.value > $1.value }
    
    let topKElements = sortedByFrequency.prefix(k).map { $0.key }
    
    return topKElements
    
}

let nums = [1, 1, 1, 2, 2, 3]
let k = 2
print(topKFrequent(nums, k))
