class Solution:
    def firstUniqChar(self, s: str) -> int:
        freq = {}
        for i in s:
            if i not in freq:
                freq[i] = 1
            else:
                freq[i] += 1
        for j in range(len(s)):
            if freq[s[j]] == 1:
                return j
        return -1