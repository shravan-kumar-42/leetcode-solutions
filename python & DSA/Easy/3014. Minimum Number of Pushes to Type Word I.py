class Solution:
    def minimumPushes(self, word: str) -> int:
        q = len(word)//8
        remainder = len(word)%8
        ans = int(8 * (q)*(q+1)/2) + ((remainder)*(q+1))   
        return ans
        